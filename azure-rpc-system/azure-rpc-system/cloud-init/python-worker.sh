#!/bin/bash

apt update -y
apt install -y python3 python3-pip

pip3 install flask

cat <<EOF > /home/azureuser/worker.py
from flask import Flask, request

app = Flask(__name__)

@app.route('/run', methods=['POST'])
def run():
    return {
        "worker":"python",
        "input":request.json
    }

@app.route('/health')
def health():
    return {"status":"ok"}

app.run(host="0.0.0.0",port=5001)
EOF

nohup python3 /home/azureuser/worker.py > /home/azureuser/python.log 2>&1 &