#!/usr/bin/env python
# -*- coding: utf-8 -*-
# hello worldié

import json
from subprocess import check_output as execute
from flask import Flask
from flask import request

app = Flask(__name__)


@app.route('/read')
def read():
    execute_result = execute([
        '/home/arnaud/.local/bin/hlcli',
        'smslist',
        '-boxType',
        '1',
        '-count',
        '20',
        '-page',
        '1',
        # '-v',
    ])

    result = {}
    try:
        _json = json.loads(execute_result)
        if ('Messages' in _json and
                'Message' in _json['Messages'] and
                len(_json['Messages']['Message']) > 0):
            for message in _json['Messages']['Message']:
                # If message is unread
                if int(message['Smstat']) == 0:
                    print('Found unread message from {}'.format(
                        message['Phone']
                    ))
                    # Copy this message
                    result['message'] = message['Content']
                    result['from'] = message['Phone']
                    result['date'] = message['Date']

                    # Mark it as read now
                    execute([
                        '/home/arnaud/.local/bin/hlcli',
                        'smsreadset',
                        '-id',
                        message['Index'],
                    ])
                    break
    except Exception:
        pass

    return json.dumps(result)


@app.route('/send', methods=['POST'])
def send():
    global token
    if (request.form['to'] and
            request.form['message'] and
            request.form['token'] == token):
        # Check that we want to send to a french mobile phone
        if (str(request.form['to']).startswith('336') or
                str(request.form['to']).startswith('337')):
            print(u'Request to send a message to +{} / {}'.format(
                request.form['to'],
                request.form['message'],
            ))
            return execute([
                '/home/arnaud/.local/bin/hlcli',
                'smssend',
                "-to=+{}".format(str(request.form['to'])),
                u"-msg={}".format(request.form['message']),
            ])

    # Being here means that the parameters were not set correcly
    return 'KO'


if __name__ == "__main__":
    global token
    # Read token
    with open('.token') as file:
        token = file.read().strip()
    app.run(host='0.0.0.0')
