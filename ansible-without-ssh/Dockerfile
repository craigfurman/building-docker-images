FROM ubuntu:trusty

RUN apt-get update \
  && apt-get install -y libffi-dev libssl-dev python python-dev python-pip \
  && pip install paramiko PyYAML Jinja2 httplib2 six pycrypto

ADD ansible /root/ansible
ADD playbook /root/playbook

RUN bash -c 'source ~/ansible/hacking/env-setup && cd ~/playbook && ansible-playbook -i hosts --con local playbook.yml'
