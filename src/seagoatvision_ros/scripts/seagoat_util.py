__author__ = 'yohan'

import ConfigParser
import rospy

def replace_filter(src_chain, dst_chain, filter):

    src_cfg = ConfigParser.ConfigParser()
    dst_cfg = ConfigParser.ConfigParser()

    src_cfg.read(src_chain)
    dst_cfg.read(dst_chain)

    rospy.loginfo("Copying {} from {} to {}".format(filter, src_chain, dst_chain))

    if not src_cfg.has_section(filter):
        rospy.logwarn("Unable to find filter {} in source filterchain {}".format(filter, src_chain))
        return
    if not dst_cfg.has_section(filter):
        rospy.logwarn("Unable to find filter {} in dest filterchain {}".format(filter, dst_chain))
        return

    out_cfg = ConfigParser.ConfigParser()
    for section in dst_cfg.sections():
        if section == filter:
            out_cfg.add_section(section)
            for option in src_cfg.options(section):
                out_cfg.set(section, option, src_cfg.get(section, option))
        else:
            out_cfg.add_section(section)
            for option in dst_cfg.options(section):
                out_cfg.set(section, option, dst_cfg.get(section, option))

    out_cfg.write(open(dst_chain, 'w'))