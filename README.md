# GitHub Runner Docker Image used for self-hosted runners.

>This Docker image is designed to be used as a GitHub Runner for self-hosted runners. When configured correctly, it allows you to run GitHub Actions workflows on your own infrastructure, rather than relying on GitHub's cloud infrastructure. By using this Docker image, you can set up a self-hosted runner quickly and easily, with all the necessary dependencies and configurations pre-installed.

>A new version of the image will be released when the GitHub Actions Runner team publishes a new release on their page, which can be found at https://github.com/actions/runner/releases. Once the new release is available, you can update your own system to use the latest version of the image.

# Requirements
 1. GitHub Repository URL
 2. [Github PAT Token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)
 
# Build 
[![Run](https://github.com/GVLTodorov/Runner/actions/workflows/run.yml/badge.svg)](https://github.com/GVLTodorov/Runner/actions/workflows/run.yml)

# Local

```docker build . -t runner```

```docker run -e "REPOSITORY=https://github.com/###/###" -e "TOKEN=###" -e "LABEL=###" -e "NAME=###" runner```

# Docker Compose

```
services:
  runner:
    image: ghcr.io/gvltodorov/runner:latest
    container_name: runner
    restart: unless-stopped
    environment:
       - REPOSITORY=https://github.com/####
       - TOKEN=###PAT#Token
       - NAME=###Agent # optional
       - LABEL=###Agent # optional
     volumes:
       - /var/run/docker.sock:/var/run/docker.sock
```

![image](https://user-images.githubusercontent.com/51453974/219865153-ccc03843-8f0d-48b4-bc2e-34969e7eddc2.png)

> runs-on: self-hosted

```
name: Default
on:
  push:
    branches: [ main ]
jobs:
  build:
    runs-on: self-hosted
    steps:
      - uses: actions/checkout@v2
      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v2
        with:
          node-version: '14.17.6'
      - run: npm ci
      - run: npm run build --if-present
      - run: npm test
```
