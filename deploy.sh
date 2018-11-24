docker build -t azrielh/complex-client:latest -t azrielh/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t azrielh/complex-server:latest -t azrielh/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t azrielh/complex-worker:latest -t azrielh/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push azrielh/complex-client:latest
docker push azrielh/complex-server:latest
docker push azrielh/complex-worker:latest

docker push azrielh/complex-client:$SHA
docker push azrielh/complex-server:$SHA
docker push azrielh/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=azrielh/complex-server:$SHA
kubectl set image deployments/client-deployment client=azrielh/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=azrielh/complex-worker:$SHA