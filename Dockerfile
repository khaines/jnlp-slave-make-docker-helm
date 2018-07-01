FROM jenkins/jnlp-slave:3.19-1
MAINTAINER Ken Haines <@khaines>

ENV DOCKER_VERSION=17.04.0-ce KUBECTL_VERSION=v1.6.6 HELM_VERSION=v2.9.1

USER root

RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Docker
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz \
	&& tar --strip-components=1 -xvzf docker-${DOCKER_VERSION}.tgz -C /usr/local/bin \
	&& chmod -R +x /usr/local/bin/docker

#Kubectl
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

#Helm
RUN curl -fsSLO https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar --strip-components=1 -xvzf helm-${HELM_VERSION}-linux-amd64.tar.gz -C /usr/local/bin \
    && chmod +x /usr/local/bin/helm

USER jenkins