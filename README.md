# Runner
Ubuntu Image with GitHub Action used for self-hosted runners

# Purpose
Used to build and host your own agents for github action.

# Requirements
 1. GitHub Repository URL
 2. Github Runner Token
 
![image](https://user-images.githubusercontent.com/51453974/131668152-2352ab6d-fe26-42c3-8d54-9669f6fd7b0c.png)
  

# Build 
[![Build](https://github.com/GVLTodorov/Runner/actions/workflows/release.yml/badge.svg)](https://github.com/GVLTodorov/Runner/actions/workflows/release.yml)

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
       - REPOSITORY= https://github.com/####
       - TOKEN= ####
       - NAME= Agent #optional
       - LABEL= Agent #optional
     volumes:
       - /var/run/docker.sock:/var/run/docker.sock
```

# Result

![image](https://user-images.githubusercontent.com/51453974/131748931-e7c32263-e146-4bee-85dc-7db6e53757c2.png)

# Usage
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
