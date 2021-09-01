# Runner
Ubuntu Image with GitHub Action used for self-hosted runners

# Purpose
Used to build and host your own build agents for github action.

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
  agent:
    image: ghcr.io/gvltodorov/runner:latest
    container_name: agent
    restart: unless-stopped
    environment:
       - REPOSITORY= https://github.com/####
       - TOKEN= ####
       - NAME= Agent #optional
       - LABEL= Agent #optional
```

# Result

![image](https://user-images.githubusercontent.com/51453974/131748931-e7c32263-e146-4bee-85dc-7db6e53757c2.png)
