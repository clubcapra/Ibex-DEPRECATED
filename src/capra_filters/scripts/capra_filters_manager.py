#!/usr/bin/env python

import rospy
from capra_filters.srv import *
from nodelet.srv import NodeletList
import dynamic_reconfigure.client
import subprocess
import yaml

namespace = None
manager_name = None
list_filter_srv = None
filterchain_file = None
filerchain = {}


def compile_launchfile(filterchain, ns='capra_filters'):
    output = '<launch>\n  <arg name="capra_filters_ns" default="%s" />\n' % namespace

    for filter_params in filterchain:
        output += '  <node pkg="nodelet" ns="%s" name="%s" type="nodelet" args="load %s /$(arg capra_filters_ns)/nodelet_manager">\n' % (ns, filter_params['name'], filter_params['type'])

        for key, value in filter_params.items():
            if key != 'name' and key != 'ns':
                output += '    <param name="%s" value="%s" />\n' % (key, value)
        output += '  </node>\n'

    output += '</launch>\n'

    return output


def handle_save_filterchain(req):
    nodelets = list_filters_srv().nodelets
    params = {}

    for nodelet in nodelets:
        parts = nodelet.split('/')[1:]

        if len(parts) == 2:
            ns, name = parts
        else:
            ns, name = '', parts[0]

        params[nodelet] = {'name': name, 'type': None, 'ns': ns}

        nodelet_params = yaml.load(subprocess.Popen(['rosparam', 'get', nodelet], stdout=subprocess.PIPE).communicate()[0])

        for key, value in nodelet_params.items():
            if type(value) is not dict:
                params[nodelet][key] = value

    config = params.values()

    launch_data = compile_launchfile(config)

    with open(req.path, 'w') as f:
        f.write(launch_data)

    return SaveFilterchainResponse()


def handle_launch_filter(req):
    subprocess.Popen(['rosrun', 'nodelet', 'nodelet', 'load', req.type, manager_name, '_type:=' + req.type, '__name:=' + req.name])

    return LaunchFilterResponse()


if __name__ == '__main__':
    rospy.init_node('capra_filters_manager')

    manager_name = rospy.resolve_name(rospy.get_param('~nodelet_manager_name', 'nodelet_manager'))
    list_filters_srv = rospy.ServiceProxy(manager_name + '/list', NodeletList)
    namespace = '/' + manager_name.split('/')[1] # yolo

    rospy.Service('~save_filterchain', SaveFilterchain, handle_save_filterchain)
    rospy.Service('~launch_filter', LaunchFilter, handle_launch_filter)

    rospy.spin()
