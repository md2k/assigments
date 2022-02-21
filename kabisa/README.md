## Task 3 (DevOps)
> NOTE: i'm assume that person who going to run these scripts have deployed Docker Desktop for MacOs
>       with enabled Kubernetes and/or have basic knowledge how to switch/set correct context for kubernete's configuration

In repository folder `3-devops` you can find start scripts to run Demo Flask application:
1. `run-flask-docker.sh` - build and run application with help of Docker Compose
2. `run-flask-k8s.sg` - build and run application with help of Kubernetes
3. `values.sh`        - some pre-defined values used by run-scripts

Regardless of chosen script, final result will be running application which can be accesses in local browser as: 
* Docker Compose: [http://127.0.0.1:8080/api/docs/](http://127.0.0.1:8080/api/docs/)
* Local Kubernetes: [http://127.0.0.1:30080/api/docs/](http://127.0.0.1:30080/api/docs/)

Each script will do cleanup (source code removal, containers removal, image removal and docker cache cleanup).

Folder's content:
* `3-devops/docker/` - custom application config, compose template
* `3-devops/k8s/` - kubernetes manifest to deploy application
* `3-devops/misc/` - Dockerfiles, one for compose, another for kubernetes

> NOTE: if you have locally different from docker-desktop kubernetes cluster, you need ensure that you adjust `K8S_CONTEXT` and `K8S_NAMESPACE` in `values.sh` accordingly to you target cluster

> NOTE: kubernete's application has 3 replicas

# To check deployed app inside kubernetes:

* Set current context to `docker-desktop` or desired one: `kubectl config use-context docker-desktop`
* Get all pods: `kubectl --namespace default get pods -lapp.kubernetes.io/name=flask-demo-app -o wide`
* Get service attached to Pods: `kubectl --namespace default get svc -lapp.kubernetes.io/name=flask-demo-app -o wide`
* Get logs for all containers with prefixes: `kubectl --namespace default logs -f -lapp.kubernetes.io/name=flask-demo-app --prefix`


## Task 4 (Web App)
Web application written in Golang.   
Under folder `4-app` you can find source folder `web-app-go` and `run-web-go.sh` script.   
Script will run docker-compose with golang container, `start.sh` script will do build and run executable with application server.   
As result you should be able to call application as follow `http://127.0.0.1:8080/`   
On each refresh, new quote will be rendered.


## Task 5 (Linux/Network)
Communication flow can be split into 3 major sections: setup/data transfer/release
NOTE: TCP mean transfer control protocol, what means each packet should have acknowledgment (ACK) packet sent back to sender (regardless who is sender).
#### Setup phase
Setup connection can have extra step where client need determine destination IP address from DNS servers (not covered here).
To initiate connection to a destination server, client sending SYN packet where it should get SYN/ACK response, final ACK from client, what will mean that client and server can continue further communications. In case protocol has SSL layer, client - server should complete HTTPS handshake (client send hello packet, Server respond with Server Hello, Key Exchange and Cipher Spec).
#### Transfer phase
Client ready to send request to destination server, as soon as server received request ACK will be sent to client. Server going to process request and respond to content/data back, as soon as response received another ACK packet will be sent to sender (in this case to server). In case ACK not received by sender (client or server) packet will be sent once again. While in higher overview ACK usually omitted, this part plays important role for entire communication's flow.
When Client got its reply from destination server, we can consider that Transfer section done. While connection still can be open using keep-alive or we can continue to communicate with server for other requests, task doesn't asking for such deep overview.
#### Release
On connection close FIN/ACK packet will be sent to server to close connection. Server side will send final ACK packet to client, but most probably this will be lost and not important since application will be closed at this moment.
