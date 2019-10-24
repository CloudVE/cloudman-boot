FROM python:3.6-alpine

ENV KUBE_LATEST_VERSION=v1.14.1
ENV HELM_VERSION=v2.14.1
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz

# pyopenssl needed to generate key/certificate for rancher/keycloak integration
RUN echo "===> Add docker..."  && \
    apk --update --no-cache add docker && \
    echo "===> Add build dependencies..."  && \
    apk add --no-cache --virtual build-deps libffi-dev openssl-dev build-base linux-headers && \
    ln -sf /usr/local/bin/python /usr/bin/python && \
    ln -sf /usr/local/bin/python /usr/bin/python3 && \
    \
    echo "===> Installing python packages..."  && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir ansible docker-py pyopenssl cloudbridge netaddr && \
    \
    echo "==> Installing latest kubectl and helm..." && \
    apk add --no-cache curl && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    curl -L https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/helm && \
    echo "===> Remove build dependencies..."  && \
    apk del build-deps

RUN mkdir -p /tmp/cm-boot
WORKDIR /tmp/cm-boot
ADD . /tmp/cm-boot

ENV ANSIBLE_DEBUG=${ANSIBLE_DEBUG:--v}
CMD ansible-playbook -i "localhost," -c local playbook.yml --tags rancher \
    $ANSIBLE_DEBUG
