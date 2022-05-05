# Glassfish application server

Glassfish docker image with admin panel enabled

# Exposed Ports

| Port number | Description                               |
|:------------|:------------------------------------------|
| 8080        | HTTP port                                 |
| 8181        | HTTPS port                                |
| 4848        | Administration port                       |
| 8686        | Pure JMX Clients Port                     |
| 7676        | Message Queue Port                        |
| 3700        | IIOP Port                                 |
| 3820        | IIOP/SSL Port                             |
| 3920        | IIOP/SSL Port With Mutual Authentication  |

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
You will see something like:

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
