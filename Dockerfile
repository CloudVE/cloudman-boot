FROM python:3.6-alpine

RUN echo "===> Add docker..."  && \
    apk --update --no-cache add docker && \
    echo "===> Add build dependencies..."  && \
    apk add --no-cache --virtual build-deps libffi-dev openssl-dev build-base  && \
    ln -sf /usr/local/bin/python /usr/bin/python && \
    ln -sf /usr/local/bin/python /usr/bin/python3 && \
    \
    echo "===> Installing python packages..."  && \
    pip install --no-cache-dir ansible docker-py && \
    \
    \
    echo "===> Remove build dependencies..."  && \
    apk del build-deps

RUN mkdir -p /tmp/cm-boot
WORKDIR /tmp/cm-boot
ADD . /tmp/cm-boot
# RUN curl -Lk https://github.com/afgane/ansible-rancher/archive/v2.0.0-alpha.tar.gz | tar -zxf-

ENV ANSIBLE_DEBUG=${ANSIBLE_DEBUG:--v}
CMD ansible-playbook -i "localhost," -c local playbook.yml --tags rancher \
    $ANSIBLE_DEBUG
