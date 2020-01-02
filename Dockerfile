FROM alpine:3.11

ENV HOME /
ENV PATH /google-cloud-sdk/bin:$PATH
ENV TF_IN_AUTOMATION=true

ARG CLOUD_SDK_VERSION=274.0.1
ARG SHA256SUM=a93434e0914194978006a107f69a4ef26c29e4778caf0bc94979dfd6386a6ebb
ARG TERRAFORM_VERSION=0.12.18

RUN set -ex \
  && apk add --update curl python bash git openssh-client \
  && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && echo "${SHA256SUM}  google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" > google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256 \
  && sha256sum -c google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256 \
  && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  && gcloud config set core/disable_usage_reporting true \
  && gcloud config set component_manager/disable_update_check true \
  && wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && mv terraform /usr/bin \
  && rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip /var/cache/apk/*
VOLUME ["/.config"]
