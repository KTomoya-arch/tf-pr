FROM --platform=linux/x86_64 google/cloud-sdk:405.0.0-alpine

ENV TF_VERSION=1.3.8 \
    TFMER_VERSION=0.8.22 \
    TFMER_PROVIDER=google

RUN apk -q update && \
    apk -q add unzip wget

RUN wget -q https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin/

RUN curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/${TFMER_VERSION}/terraformer-${TFMER_PROVIDER}-linux-amd64 && \
    chmod +x terraformer-${TFMER_PROVIDER}-linux-amd64 && \
    mv terraformer-${TFMER_PROVIDER}-linux-amd64 /usr/local/bin/terraformer