docker build -t sharmavks85/multi-client:latest -t sharmavks85/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sharmavks85/multi-server:latest -t sharmavks85/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sharmavks85/multi-worker:latest -t sharmavks85/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sharmavks85/multi-client:latest
docker push sharmavks85/multi-server:latest
docker push sharmavks85/multi-worker:latest

docker push sharmavks85/multi-client:$SHA
docker push sharmavks85/multi-server:$SHA
docker push sharmavks85/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sharmavks85/multi-server:$SHA
kubectl set image deployments/client-deployment client=sharmavks85/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sharmavks85/multi-worker:$SHA