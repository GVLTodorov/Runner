# Runner Image
Ubuntu Image with GitHub Action used for self-hosted runners

# Auto build and publish image
New version will pop compares to https://github.com/actions/runner/releases

# Purpose
Used to build and host your own agents for github action.

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
       - PUID=1000
       - PGID=1000
       - REPOSITORY=https://github.com/####
       - TOKEN=###PAT#Token
       - NAME=###Agent # optional
       - LABEL=###Agent # optional
     volumes:
       - /var/run/docker.sock:/var/run/docker.sock
```

# Result

![image](https://user-images.githubusercontent.com/51453974/131748931-e7c32263-e146-4bee-85dc-7db6e53757c2.png)

# YML Example
```
runs-on: self-hosted
```

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
