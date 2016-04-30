#!/usr/bin/env python

import sys
import yaml

def compile_launchfile(filterchain, ns='capra_filters'):
    output = '<launch>\n  <arg name="nodelet_manager_name" />\n'

    for filter in filterchain:
        output += '  <node pkg="nodelet" ns="%s" name="%s" type="nodelet" args="load %s $(arg nodelet_manager_name)">\n' % (ns, filter['name'], filter['type'])

        for key, value in filter.items():
            if key != 'name' and key != 'ns':
                output += '    <param name="%s" value="%s" />\n' % (key, value)
        output += '  </node>\n'

    output += '</launch>\n'

    return output


if __name__ == '__main__':

    if len(sys.argv) <= 1:
        print 'Usage: %s [input.yaml]' % sys.argv[0]
        sys.exit(1)

    with open(sys.argv[1]) as f:
        print compile(yaml.load(f))
