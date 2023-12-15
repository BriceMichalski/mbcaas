FROM ubuntu:22.04

ENV HELM_PLUGINS="/opt/helm/plugin"

RUN cd /tmp \
    && apt update \
    && apt install curl git python3 python3-pip  age -y \
    # TELEPORT
    && curl https://goteleport.com/static/install.sh | bash -s 14.2.1 \
    # KUBECTL
    && curl -L -o /usr/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    # K9S
    && curl -L -O https://github.com/derailed/k9s/releases/download/v0.28.2/k9s_Linux_amd64.tar.gz \
    && tar -xvf k9s_Linux_amd64.tar.gz \
    && mv k9s /usr/bin \
    # HELM
    && curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null \
    && apt-get install apt-transport-https --yes \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
    && apt-get update \
    && apt-get install helm \
    # HELM PLUGINS
    && helm plugin install https://github.com/databus23/helm-diff \
    && helm plugin install https://github.com/jkroepke/helm-secrets \
    ## HELMFILE
    && curl -L -O https://github.com/helmfile/helmfile/releases/download/v0.159.0/helmfile_0.159.0_linux_amd64.tar.gz \
    && tar -xvf helmfile_0.159.0_linux_amd64.tar.gz \
    && mv helmfile /usr/bin/helmfile \
    # SOPS
    && curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64 \
    && mv sops-v3.8.1.linux.amd64 /usr/bin/sops \
    # TOOLS
    && cd /tmp \
    && curl -L -o /usr/bin/jq https://github.com/jqlang/jq/releases/download/jq-1.7/jq-linux-amd64 \
    && curl -L -o /usr/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
    && curl -LO https://github.com/homeport/dyff/releases/download/v1.6.0/dyff_1.6.0_linux_amd64.tar.gz \
    && tar -xvf dyff_1.6.0_linux_amd64.tar.gz \
    && mv dyff /usr/bin/dyff \
    # clean
    && rm -rf /tmp/* \
    # USER
    && useradd mbcaas-tools --uid 501 --create-home \
    && mkdir /workdir \
    && chown mbcaas-tools /workdir \
    # MAKE EXEC
    && chmod +x /usr/bin/*


COPY --chmod=0755 ./entrypoint.sh /docker-entrypoint.sh

ENV MBCAAS_ROOT_DIR="/workdir"
ENV PATH="$PATH:/workdir/bin"

COPY ./.bashrc /home/mbcaas-tools/.bashrc

WORKDIR "/workdir"
USER "mbcaas-tools"

ENTRYPOINT ["/docker-entrypoint.sh"]
