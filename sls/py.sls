#!py
# -*- coding: utf-8 -*-
# vim: ts=4 sw=4 et

__formula__ = 'template'


def run():
    config = {}
    datamap = __salt__['formhelper.get_defaults'](__formula__, __env__, ['yaml'])['yaml']
    _gen_state = __salt__['formhelper.generate_state']

    # SLS includes/ excludes
    config['include'] = datamap.get('sls_include', [])
    config['extend'] = datamap.get('sls_extend', {})

    # Test states
    attrs = [
        {'name': 'echo The time is $(date)'},
        ]

    state_id = 'cmd_date'
    config[state_id] = _gen_state('cmd', 'run', attrs)

    attrs = [
        {'name': 'echo Your system is \'{system}\''.format(system=datamap['system'])},
        ]

    state_id = 'cmd_system'
    config[state_id] = _gen_state('cmd', 'run', attrs)

    return config
