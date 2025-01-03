FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    rpm \
    dpkg-dev \
    build-essential \
    git \
    curl \
    sudo \
	bash \
	docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER jenkins