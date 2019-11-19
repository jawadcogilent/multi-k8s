#!/bin/bash

docker build -t jawadcogilent/multi-client -f ./client/Dockerfile ./client
docker build -t jawadcogilent/multi-server -f ./server/Dockerfile ./server
docker build -t jawadcogilent/multi-worker -f ./worker/Dockerfile ./worker

docker push jawadcogilent/multi-client
docker push jawadcogilent/multi-server
docker push jawadcogilent/multi-worker

kubectl apply -f k8s
#kubectl set image deployments/server-deployment server=jawadcogilent/multi-server
kubectl rollout restart deployment server-deployment
kubectl rollout restart deployment client-deployment
kubectl rollout restart deployment worker-deployment


