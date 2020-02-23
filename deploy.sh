docker build -t lzaltzberg/multi-client:latest -t lzaltzberg/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lzaltzberg/multi-server:latest -t lzaltzberg/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lzaltzberg/multi-worker:latest -t lzaltzberg/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lzaltzberg/multi-client:latest
docker push lzaltzberg/multi-server:latest
docker push lzaltzberg/multi-worker:latest

docker push lzaltzberg/multi-client:$SHA
docker push lzaltzberg/multi-server:$SHA
docker push lzaltzberg/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lzaltzberg/multi-server:$SHA
kubectl set image deployments/client-deployment client=lzaltzberg/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lzaltzberg/multi-worker:$SHA