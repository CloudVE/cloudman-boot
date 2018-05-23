FROM ubuntu:16.04
RUN sed -i 's/main/main universe multiverse/' /etc/apt/sources.list
RUN apt-get update -q

RUN apt-get install -qy \
    software-properties-common python python-dev python-apt python-pip
RUN apt-get install -qy build-essential
RUN apt-get install -qy curl docker.io

# Update pip
RUN python -m pip install pip --upgrade
RUN python -m pip install wheel docker-py

RUN pip install ansible

RUN mkdir -p /tmp/ansible
WORKDIR /tmp/ansible
ADD . /tmp/ansible
# RUN curl -Lk https://github.com/afgane/ansible-rancher/archive/v2.0.0-alpha.tar.gz | tar -zxf-

ENV ANSIBLE_DEBUG=${ANSIBLE_DEBUG:--v}
CMD ansible-playbook -i "localhost," -c local playbook.yml --tags rancher \
    $ANSIBLE_DEBUG
