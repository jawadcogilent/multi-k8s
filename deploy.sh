#!/bin/bash

docker build -t jawadcogilent/multi-client:latest -t jawadcogilent/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jawadcogilent/multi-server:latest -t jawadcogilent/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jawadcogilent/multi-worker:latest -t jawadcogilent/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jawadcogilent/multi-client:latest
docker push jawadcogilent/multi-server:latest
docker push jawadcogilent/multi-worker:latest

docker push jawadcogilent/multi-client:$SHA
docker push jawadcogilent/multi-server:$SHA
docker push jawadcogilent/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=jawadcogilent/multi-client:$SHA
kubectl set image deployments/server-deployment server=jawadcogilent/multi-server:$SHA
kubectl set image deployments/worker-deployment server=jawadcogilent/multi-worker:$SHA

## Uncomment the below lines only if you use kubectl version 1.16 or above
#kubectl rollout restart deployment deployment/server-deployment
#kubectl rollout restart deployment deployment/client-deployment
#kubectl rollout restart deployment deployment/worker-deployment