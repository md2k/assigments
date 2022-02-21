#!/usr/bin/env sh

source ./values.sh

echo "Cloning ${REPO} into ${K8S_TARGET} dir..."
mkdir -p ${K8S_TARGET}
git clone ${REPO} ${K8S_TARGET}/src

echo "Build Demo app image..."
docker build -t ${K8S_IMAGE_TAG} -f misc/Dockerfile-k8s ${K8S_TARGET}

echo "Deploying App into Kubernetes cluster..."
kubectl config use-context ${K8S_CONTEXT}
kubectl apply --namespace ${K8S_NAMESPACE} -f ${K8S_TARGET}/ --wait

echo "Application should be accessible by url: http://127.0.0.1:30080/api/docs/"

read -n 1 -s -r -p "Press any key to Cleanup"
echo "\nCleanup images/caches/layers/sources...."
kubectl delete --namespace ${K8S_NAMESPACE} -f ${K8S_TARGET}/ --wait --cascade=foreground
docker image rm ${K8S_IMAGE_TAG}
docker image prune -f
docker builder prune -f
rm -rf ${K8S_TARGET}/src
