#!/bin/bash

apt-get update -y
apt-get install -y python3 python3-pip

pip3 install flask requests

cat <<EOF > /home/ubuntu/engine.py
from flask import Flask, request
import requests

app = Flask(__name__)

PYTHON = "http://10.0.2.11:5001"
TS = "http://10.0.2.12:5002"

@app.route("/process", methods=["POST"])
def process():

    data = request.json

    p = requests.post(
        PYTHON + "/run",
        json=data
    ).json()

    t = requests.post(
        TS + "/run",
        json=p
    ).json()

    return t

@app.route("/health")
def health():
    return {"status":"ok"}

app.run(host="0.0.0.0", port=6000)
EOF

nohup python3 /home/ubuntu/engine.py > /home/ubuntu/engine.log 2>&1 &