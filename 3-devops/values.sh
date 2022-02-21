CURRENT=$PWD
REPO="https://github.com/matdoering/minimal-flask-example.git"

# DOCKER
DOCKER_TARGET="${CURRENT}/docker"

# K8S
# NOTE: Requires to have Docker Desktop (Windows/MacOs) with enabled Kubernetes.
K8S_TARGET="${CURRENT}/k8s"
K8S_IMAGE_TAG="flask-demo-app:latest"

# Change this if cluster / namespace different
K8S_CONTEXT=docker-desktop
K8S_NAMESPACE=default
