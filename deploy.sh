docker build -t paakcmd/multi-client:latest -t paakcmd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paakcmd/multi-server:latest -t paakcmd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paakcmd/multi-worker:latest -t paakcmd/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push paakcmd/multi-client:latest
docker push paakcmd/multi-server:latest
docker push paakcmd/multi-worker:latest

docker push paakcmd/multi-client:$SHA
docker push paakcmd/multi-server:$SHA
docker push paakcmd/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=paakcmd/multi-server:$SHA
kubectl set image deployments/client-deployment client=paakcmd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paakcmd/multi-worker:$SHA
