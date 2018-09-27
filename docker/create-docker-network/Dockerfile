# Dockerfile for creating a container image that is used to run
# an init container on Kubernetes for creating the OpenWhisk
# action container network with Docker.
#
# Runs an Ansible playbook to create / update a Docker network.

FROM alpine

ENV LANG C.UTF-8

ENV ANSIBLE_VERSION 2.5.2
ENV ANSIBLE_DEPS "build-base python-dev libffi-dev openssl-dev"

RUN apk --no-progress update && \
    \
    \
    # Install general packages
    apk --no-progress --update add \
        bash \
        sudo \
        openssl \
        ca-certificates \
        tar \
        unzip && \
    \
    \
    # Install Python, pip and depencies required to install Ansible
    apk --no-progress --update add \
        python2 \
        py2-pip \
        ${ANSIBLE_DEPS} && \
    \
    \
    # Upgrade pip and cffi
    pip install --upgrade pip cffi && \
    \
    \
    # Install Ansible
    pip install "ansible>=${ANSIBLE_VERSION}" && \
    \
    \
    # Remove dependencies which were only required to install Ansible
    apk --no-progress del ${ANSIBLE_DEPS} && \
    \
    \
    # Clean apk indices
    rm -rf /var/cache/apk/* && \
    \
    \
    # Create default Ansible hosts file
    mkdir -p /etc/ansible && \
    echo 'localhost ansible_connection=local' > /etc/ansible/hosts


ENV DOCKER_VERSION 18.03.1-ce

    # Download Docker
RUN wget --quiet --output-document "/tmp/docker-${DOCKER_VERSION}.tgz" "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" && \
    \
    \
    # Extract Docker CLI and make it executable
    # Need to extract to /tmp to get rid of the extra "docker" directory
    tar -zxvf "/tmp/docker-${DOCKER_VERSION}.tgz" -C /tmp/ docker/docker && \
    mv /tmp/docker/docker /usr/bin/docker && \
    chmod u=rwx,go=rx /usr/bin/docker && \
    \
    \
    # Remove temporary files
    rm -rf "/tmp/docker-${DOCKER_VERSION}.tgz" /tmp/docker/ && \
    \
    \
    # Install Docker module for Ansible
    # This was `docker-py>=1.7.0` before - see https://docker-py.readthedocs.io/en/stable/
    pip install "docker>=3.2.0"

COPY createNetwork.yml /createNetwork.yml

CMD ["/usr/bin/ansible-playbook", "/createNetwork.yml", "--limit=localhost"]
