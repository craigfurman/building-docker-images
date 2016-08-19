#!/usr/bin/env bash
set -eu
set -o pipefail

building_container_name=test
built_image_name=craigfurman/htop

if [ -z "${1:-}" ]; then
  echo "usage: run.sh <docker host>"
  exit 1
fi

docker_host=$1
shift

ssh_image="craigfurman/ubuntu-with-ssh-server"
if ! docker images | grep $ssh_image > /dev/null 2>&1; then
  echo "you must build the image in the ubuntu-ssh-image directory before running this script"
  exit 1
fi

(
cd $(dirname $0)
bundle install
bundle exec mustache <(echo "{\"docker-host\": \"$docker_host\"}") hosts.mustache > hosts
ssh-keygen -t rsa -N '' -f id_rsa
docker run -p 2222:22 -d --name $building_container_name $ssh_image bash -c "mkdir -p ~/.ssh && echo $(cat id_rsa.pub) >> ~/.ssh/authorized_keys && service ssh start && sleep infinity"

ansible-playbook -i hosts playbook.yml
docker exec $building_container_name bash -c 'service ssh stop && apt-get remove -y openssh-server'
docker stop $building_container_name
docker commit $building_container_name $built_image_name
docker rm $building_container_name
rm id_rsa*
)
