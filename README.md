# containerd-runtime

## build docker image and run it within docker engines runtime

    yarn
    yarn docker-build
    export GIT_COMMIT_SHORT=$(git rev-parse --short=8 HEAD)
    docker run --name containerD -p 3000:3000 containerd-example:$GIT_COMMIT_SHORT

## Run the K8 cluster and run the docker image within K8 cluster having containerD as runtime envt instead of docker

    brew install k3d
    brew install docker --cask

    sudo nano /etc/hosts
    127.0.0.1	mycluster-registry

    k3d cluster create \
    --port 9900:80@loadbalancer \
    --port 9901:443@loadbalancer \
    --k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@agent:*' \
    --k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@agent:*' \
    --servers 1 --agents 1 --registry-create mycluster-registry:0.0.0.0:5000

    yarn docker-build-tag-push-local
    kubectl apply -f ./deployment.yaml

    kubectl  apply -f ./ingress.yaml

    Veriy API is accessible --> http://localhost:9900/

    k3d cluster delete k3s-default

    docker rmi -f $(docker images | grep 'containerd-example')

### NOTE

    Default configuration of K3d -->
    https://rancher.com/docs/k3s/latest/en/advanced/#using-docker-as-the-container-runtime
