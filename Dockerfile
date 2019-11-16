FROM ubuntu:18.04

ENV KUBE_LATEST_VERSION=v1.16.2
ENV HELM_VERSION=v2.15.2
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV PYTHONUNBUFFERED 1
ARG DEBIAN_FRONTEND=noninteractive

RUN echo "===> Installing system packages and docker..." \
    && apt-get -qq update && apt-get install -y --no-install-recommends \
        curl \
        docker.io \
        python3-pip \
        python3-setuptools \
    && echo "===> Setup python..."  \
    # Remove Python 2
    && apt remove -y python \
    # Set Python 3 as the default Python installation
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1 \
    && pip3 install --no-cache-dir --upgrade pip \
    # https://github.com/pypa/pip/issues/5221#issuecomment-381568428
    && hash -r pip \
    # pyopenssl needed to generate key/certificate for rancher/keycloak integration
    # netaddr is for ansible's ipaddr module
    && pip3 install --no-cache-dir ansible docker-py pyopenssl cloudbridge netaddr \
    && echo "==> Installing latest kubectl and helm..." \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && curl -L https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 \
    && chmod +x /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/helm \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* \
    && mkdir -p /tmp/cm-boot

WORKDIR /tmp/cm-boot
ADD . /tmp/cm-boot

ENV ANSIBLE_DEBUG=${ANSIBLE_DEBUG:--v}
CMD ansible-playbook -i "localhost," -c local playbook.yml --tags cloudman-boot \
    $ANSIBLE_DEBUG
