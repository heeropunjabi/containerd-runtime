
#!/bin/bash 
source ./DockerBuild.sh
#echo $GIT_COMMIT_SHORT $GIT_COMMIT $BRANCH_NAME
docker tag containerd-example:$GIT_COMMIT_SHORT mycluster-registry:5000/containerd-example:$GIT_COMMIT_SHORT 
docker push mycluster-registry:5000/containerd-example:$GIT_COMMIT_SHORT
echo 'Please use this tag in your deployment.yaml -->' $GIT_COMMIT_SHORT