docker build -t jamiecramb/multi-client:latest -t jamiecramb/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t jamiecramb/multi-server:latest -t jamiecramb/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t jamiecramb/multi-worker:latest -t jamiecramb/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push jamiecramb/multi-client:latest
docker push jamiecramb/multi-server:latest
docker push jamiecramb/multi-worker:latest
docker push jamiecramb/multi-client:$GIT_SHA
docker push jamiecramb/multi-server:$GIT_SHA
docker push jamiecramb/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment multi-server=jamiecramb/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment multi-client=jamiecramb/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment multi-worker=jamiecramb/multi-worker:$GIT_SHA