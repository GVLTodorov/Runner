FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV RUNNER_VERSION=2.281.0
ENV TZ=Europe/Sofia

ENV PUID=1000
ENV PGID=1000

RUN apt-get update -y && apt-get upgrade -y && useradd -m ${PUID}

RUN apt-get install -y --no-install-recommends curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev

RUN cd /home/${PUID} && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN chown -R ${PUID} ~${PUID} && /home/docker/actions-runner/bin/installdependencies.sh

COPY entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh

RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN chmod +x get-docker.sh
RUN sh get-docker.sh

USER ${PUID}

ENTRYPOINT ["./entrypoint.sh"]
