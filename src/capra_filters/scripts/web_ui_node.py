#!/usr/bin/env python
import uuid
import sys

import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.websocket

import rospy
from sensor_msgs.msg import Image
from sensor_msgs.msg import PointCloud2
from sensor_msgs.msg import CompressedImage
import ros_vision.msg
import ros_vision.srv

from cv_bridge import CvBridge
import cv2
import os.path
import base64
import json
import signal
from WebUI.util.message_encoder import MessageEncoder
import datetime

class MasterHandler(tornado.websocket.WebSocketHandler):
    clients = set()

    def open(self):
        print 'MasterHandler opened'

        self.id = uuid.uuid4()
        MasterHandler.clients.add(self)

        rospy.wait_for_service('/master_node/get_workspace')
        get_workspace = rospy.ServiceProxy('/master_node/get_workspace', ros_vision.srv.GetWorkspace)
        self.write_message(json.dumps(get_workspace(), cls=MessageEncoder))

    def on_message(self, message):
        data = json.loads(message)

        for service_name in data.keys():
            service_data = data[service_name]
            req = None
            service = None

            if service_name == "set_parameter" or service_name == "set_input":
                formatted_service_name = '/%s/set_parameter' % service_data["filter_group_name"]

                req = ros_vision.srv.SetParameterValueRequest()
                req.filter_name = service_data["filter_name"]
                req.parameter_name = service_data["parameter_name"]
                req.parameter_value = str(service_data["parameter_value"])
                req.update_topics = (service_name == "set_input")

                rospy.wait_for_service(formatted_service_name)
                service = rospy.ServiceProxy(formatted_service_name, ros_vision.srv.SetParameterValue)

                if service_name == "set_input":
                    MasterHandler.notify_clients({
                        "input":
                        {
                            "source_id": service_data["source_id"],
                            "target_id": service_data["target_id"],
                            "delete": service_data["delete"]
                        }
                    }, self)
                else:
                    MasterHandler.notify_clients({
                        "parameter":
                        {
                            "name": service_data["parameter_name"],
                            "value": str(service_data["parameter_value"])
                        }
                    }, self)
            elif service_name == "get_parameter":
                formatted_service_name = '/%s/%s' % (service_data["filter_group_name"], service_name)

                req = ros_vision.srv.GetParameterValueRequest()
                req.filter_name = service_data["filter_name"]
                req.parameter_name = service_data["parameter_name"]

                rospy.wait_for_service(formatted_service_name)
                service = rospy.ServiceProxy(formatted_service_name, ros_vision.srv.GetParameterValue)

                self.write_message(json.dumps({
                    "parameter":
                    {
                        "name": service_data["parameter_name"],
                        "value": service(req).parameter_value
                    }
                }))

                return
            elif service_name == "create_filter":
                formatted_service_name = '/%s/%s' % (service_data["filter_group_name"], service_name)

                req = ros_vision.srv.CreateFilterRequest()
                req.name = service_data["filter_name"]
                req.type = service_data["type"]
                req.order = service_data["order"]

                rospy.wait_for_service(formatted_service_name)
                service = rospy.ServiceProxy(formatted_service_name, ros_vision.srv.CreateFilter)

                MasterHandler.notify_clients({
                    "filter":
                    {
                        "filter_group_name": service_data["filter_group_name"],
                        "filter_name": service_data["filter_name"],
                        "type": service_data["type"],
                        "order": service_data["order"]
                    }
                 }, self)
            elif service_name == "delete_filter":
                formatted_service_name = '/%s/%s' % (service_data["filter_group_name"], service_name)

                req = ros_vision.srv.DeleteFilterRequest()
                req.name = service_data["filter_name"]

                rospy.wait_for_service(formatted_service_name)
                service = rospy.ServiceProxy(formatted_service_name, ros_vision.srv.DeleteFilter)

                MasterHandler.notify_clients({
                    "filter":
                    {
                        "filter_group_name": service_data["filter_group_name"],
                        "filter_name": service_data["filter_name"]
                    }
                }, self)
            elif service_name == "create_filtergroup":
                formatted_service_name = '/master_node/%s' % service_name

                req = ros_vision.srv.CreateFilterGroupRequest()
                req.name = service_data["filter_group_name"]
                req.order = service_data["order"]

                rospy.wait_for_service(formatted_service_name)
                service = rospy.ServiceProxy(formatted_service_name, ros_vision.srv.CreateFilterGroup)

                MasterHandler.notify_clients({
                    "filtergroup":
                    {
                        "filter_group_name": service_data["filter_group_name"],
                        "order": service_data["order"]
                    }
                }, self)
            elif service_name == "delete_filtergroup":
                formatted_service_name = '/master_node/%s' % service_name

                req = ros_vision.srv.DeleteFilterGroupRequest()
                req.name = service_data["filter_group_name"]

                rospy.wait_for_service(formatted_service_name)
                service = rospy.ServiceProxy(formatted_service_name, ros_vision.srv.DeleteFilterGroup)

                MasterHandler.notify_clients({
                    "filtergroup":
                    {
                        "filter_group_name": service_data["filter_group_name"]
                    }
                }, self)

            service(req)

    def on_close(self):
        MasterHandler.clients.remove(self)

    @staticmethod
    def notify_clients(data=None, exclude=None):
        if data is None:
            rospy.wait_for_service('/master_node/get_workspace')
            get_workspace = rospy.ServiceProxy('/master_node/get_workspace', ros_vision.srv.GetWorkspace)
            data = get_workspace()

        if exclude is not None:
            MasterHandler.clients.discard(exclude)

        [client.write_message(json.dumps(data, cls=MessageEncoder)) for client in MasterHandler.clients]

        if exclude is not None:
            MasterHandler.clients.add(exclude)

class WebUI(tornado.web.Application):
    def __init__(self):
        base_dir = os.path.dirname(os.path.abspath(__file__))
        handlers = [
            (r"/", DashBoardHandler),
            (r"/styles/(.*)", tornado.web.StaticFileHandler, {"path": base_dir + "/WebUI/assets/css"}),
            (r"/scripts/(.*)", tornado.web.StaticFileHandler, {"path": base_dir + "/WebUI/assets/js"}),
            (r"/images/(.*)", tornado.web.StaticFileHandler, {"path": base_dir + "/assets/img"}),
            (r"/fonts/(.*)", tornado.web.StaticFileHandler, {"path": base_dir + "/assets/fonts"}),
            (r"/input([0-9]+)/", InputsHandler),
            (r"/topics/", TopicsHandler),
            (r"/filters/", FiltersHandler),
            (r"/master/", MasterHandler),
            (r"/load/", LoadHandler),
            (r"/save/", SaveHandler)
        ]
        settings = dict(
            title=u"ROS CVM",
            static_path=os.path.join(os.path.dirname(__file__), "WebUI/assets"),
            template_path=os.path.join(os.path.dirname(__file__), "WebUI/views"),
            xsrf_cookies=True,
            debug=True,
        )
        tornado.web.Application.__init__(self, handlers, **settings)

class DashBoardHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('dashboard.html')

class InputsHandler(tornado.websocket.WebSocketHandler):
    def open(self, topic):
        print 'InputsHandler opened'

        self.input_subscriber = None

    def on_message(self, message):
        topic, type = message.split(',')

        if self.input_subscriber is not None:
            self.input_subscriber.unregister()

        if type in input_topic_types:
            self.input_subscriber = rospy.Subscriber(topic, input_topic_types[type], self.on_image)
        else:
            self.write_message(type)

    def on_image(self, image):
        img = CvBridge().imgmsg_to_cv2(image)

        if self.ws_connection is not None:
            self.write_message(cv2.imencode('.jpg', img)[1].tostring(), binary=True)

class TopicsHandler(tornado.websocket.WebSocketHandler):
    def open(self):
        print 'TopicsHandler opened'

        self.send_topics()

    def send_topics(self):
        filtered_topics = {}
        for value, key in rospy.get_published_topics():
            if key in input_topic_types:
                filtered_topics.setdefault(key, []).append(value)

        self.write_message(json.dumps(filtered_topics))
        tornado.ioloop.IOLoop.instance().add_timeout(client_refresh_rate, self.send_topics)

class FiltersHandler(tornado.websocket.WebSocketHandler):
    def open(self):
        print 'FiltersHandler opened'

        rospy.wait_for_service('/master_node/list_filter_types')
        list_filter_types = rospy.ServiceProxy('/master_node/list_filter_types', ros_vision.srv.ListFilterTypes)
        self.write_message(json.dumps(list_filter_types().filter_list.filters, cls=MessageEncoder))

class LoadHandler(tornado.websocket.WebSocketHandler):
    def open(self):
        print 'LoadHandler opened'

        rospy.wait_for_service('/master_node/list_workspaces')
        list_workspaces = rospy.ServiceProxy('/master_node/list_workspaces', ros_vision.srv.ListWorkspaces)
        self.write_message(json.dumps(list_workspaces().workspaces))

    def on_message(self, message):
        req = ros_vision.srv.LoadWorkspaceRequest()
        req.name = message.encode('ascii','ignore')

        rospy.wait_for_service('/master_node/load_workspace')
        load_workspace = rospy.ServiceProxy('/master_node/load_workspace', ros_vision.srv.LoadWorkspace)
        MasterHandler.notify_clients(load_workspace(req))

class SaveHandler(tornado.websocket.WebSocketHandler):
    def on_message(self, message):
        req = ros_vision.srv.SaveWorkspaceRequest()
        req.name = message

        rospy.wait_for_service('/master_node/save_workspace')
        save_workspace = rospy.ServiceProxy('/master_node/save_workspace', ros_vision.srv.SaveWorkspace)
        save_workspace(req)

rospy.init_node('web_ui')

client_refresh_rate = datetime.timedelta(seconds=rospy.get_param('~input_topic_refresh_rate', 1))
input_topic_types = rospy.get_param('~input_topic_types', {'sensor_msgs/Image' : Image, 'sensor_msgs/PointCloud2': PointCloud2, 'sensor_msgs/CompressedImage' : CompressedImage})
port = int(rospy.get_param('~port', '8888'))

def signal_handler(signum, frame):
    print 'stopping...'

    tornado.ioloop.IOLoop.instance().stop()
    sys.exit(0)

http_server = tornado.httpserver.HTTPServer(WebUI())
http_server.listen(port)
signal.signal(signal.SIGINT, signal_handler)
tornado.ioloop.IOLoop.instance().start()
