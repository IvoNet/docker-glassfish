# Glassfish application server

Glassfish docker image with admin panel enabled

# Exposed Ports

| Port number | Description                                               |
|:------------|:----------------------------------------------------------|
| 8080        | internal address where the server runs                    |
| 4848        | internal address where the admin panel can be accessed.   |

# Volumes

| Volume path                                          | Description                                                                                                     |
|:-----------------------------------------------------|:----------------------------------------------------------------------------------------------------------------|
| /opt/glassfish6/glassfish/domains/domain1/autodeploy | The auto deploy folder for web archives (war) can be accessed in a Dockerfile with the `${DEPLOY_DIR}` variable |

# Environment variables

| Variable name    | Description                                                                                   | Default              |
|:-----------------|:----------------------------------------------------------------------------------------------|:---------------------|
| ADMIN_PASSWORD   | The admin password for [http://localhost:4848](http://localhost:4848). | <generated>          |


## Usage

```shell
docker run \
  -d \
  --name glassfish \
  -e ADMIN_PASSWORD=S3cr3t \
  -p 8080:8080 \
  -p 4848:4848 \
  ivonet/glassfish
```

If you omit the ADMIN_PASSWORD line a password will be generated for you.
You will see somthing like:

```shell
################################################################
########## GENERATED ADMIN PASSWORD: OtOCD2CS4lRdoelW  #########
################################################################
```

## Build

```shell
docker build -t [HANDLE/]<IMAGE>[:TAG] .
```

Basic:

```shell
docker build -t glassfish .
```
