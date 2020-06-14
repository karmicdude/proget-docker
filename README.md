# Dockerized ProGet  

![ProGet 5.3.3](https://img.shields.io/badge/ProGet-5.3.3-blue) ![SQL Server 2019](https://img.shields.io/badge/SQL%20Server-2019-blue) ![nginx 1.19](https://img.shields.io/badge/nginx-1.19-blue)  

This is example repository with dockerized **ProGet Server**, **MS SQL Server 2019** and **Nginx** as reverse proxy.  

At the time the repository was created, official ProGet image of old version and not maintained yet; *Dockerfile* does't have a working CMD command.  

You can set the required variables in `docker-compose.yaml`, for example, the version of *ProGet*. The list below is which variables you can change by passing it to the env:  

`PROGET_DB_TYPE`  
`PROGET_DB_HOST`  
`PROGET_DB_NAME`  
`PROGET_DB_USER`  
`PROGET_DB_PASS`  

## Installation  

```bash
# change the environment variables before
docker-compose up -d proget-db
docker-compose exec proget-db \
  /opt/mssql-tools/bin/sqlcmd \
    -S localhost \
    -U SA \
    -P '<password>' \
    -Q 'CREATE DATABASE [YOUR_DB_NAME] COLLATE SQL_Latin1_General_CP1_CI_AS'
docker-compose up -d proget proget-nginx
```