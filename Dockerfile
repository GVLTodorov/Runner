FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Sofia
ENV RUNNER_ALLOW_RUNASROOT=1

RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

RUN apt-get install -y --no-install-recommends curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev

RUN RUNNER_VERSION=$(curl https://api.github.com/repos/actions/runner/tags | grep -o '"name": "[^"]*' | grep -o '[^v]*$' -m1) \
    && echo $RUNNER_VERSION \
    && cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

COPY entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh

RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN chmod +x get-docker.sh
RUN sh get-docker.sh

ENTRYPOINT ["./entrypoint.sh"]
