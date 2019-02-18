FROM alpine:3.8
MAINTAINER Brendan Beveridge <brendan@nodeintegration.com.au>

# Some essential build tools
RUN apk add --no-cache --virtual .build-deps \
      curl

# Tool Versions
ENV PACKER_VERSION=1.3.4 \
    VAGRANT_VERSION=2.2.3 \
    TERRAFORM_VERSION=0.11.11 \
    CONSUL_VERSION=1.4.2 \
    VAULT_VERSION=1.0.3 \
    NOMAD_VERSION=0.8.7

RUN echo "packer ${PACKER_VERSION} https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" >> /hashicorp.tools.conf \
    && echo "vagrant ${VAGRANT_VERSION} https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_linux_amd64.zip" >> /hashicorp.tools.conf \
    && echo "terraform ${TERRAFORM_VERSION} https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" >> /hashicorp.tools.conf \
    && echo "consul ${CONSUL_VERSION} https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip" >> /hashicorp.tools.conf \
    && echo "vault ${VAULT_VERSION} https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" >> /hashicorp.tools.conf \
    && echo "nomad ${NOMAD_VERSION} https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip" >> /hashicorp.tools.conf

RUN cd /usr/local/bin/ \
    && cat /hashicorp.tools.conf | while read tool; do name=$(echo $tool | cut -f1 -d' '); version=$(echo $tool | cut -f2 -d' '); url=$(echo $tool | cut -f3 -d' '); \
      echo "name: ${name} version: ${version} url: ${url}" \
      && curl -L ${url} -o ${name}.zip \
      && unzip ${name}.zip \
      && chmod u+x ${name} \
      && rm ${name}.zip \
    ; done

# Cleanup
RUN apk del --purge .build-deps

RUN mkdir /workspace
COPY boot /usr/local/bin/
COPY bootstrap /workspace/
WORKDIR /workspace
