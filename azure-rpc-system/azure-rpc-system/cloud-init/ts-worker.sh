#!/bin/bash

apt update -y
apt install -y nodejs npm

mkdir /home/azureuser/tsworker
cd /home/azureuser/tsworker

npm init -y
npm install express

cat <<EOF > index.js
const express=require("express");

const app=express();

app.use(express.json());

app.post("/run",(req,res)=>{
 res.json({
   worker:"typescript",
   input:req.body
 });
});

app.get("/health",(req,res)=>{
 res.json({status:"ok"});
});

app.listen(5002,"0.0.0.0");
EOF

nohup node index.js > ts.log 2>&1 &