#!/bin/bash

apt-get update -y
apt-get install -y python3 python3-pip

pip3 install flask

cat <<EOF > /home/ubuntu/worker.py
from flask import Flask, request

app = Flask(__name__)

@app.route("/run", methods=["POST"])
def run():
    return {
        "worker": "python",
        "input": request.json
    }

@app.route("/health")
def health():
    return {"status":"ok"}

app.run(host="0.0.0.0", port=5001)
EOF

nohup python3 /home/ubuntu/worker.py > /home/ubuntu/python.log 2>&1 &