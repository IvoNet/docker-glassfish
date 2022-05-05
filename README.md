# Glassfish application server

Glassfish docker image with admin panel enabled

## Usage

| Variable name    | Description                                                                                   | Default              |
|:-----------------|:----------------------------------------------------------------------------------------------|:---------------------|
| ADMIN_PASSWORD   | The admin password for [http://localhost:4848](http://localhost:4848). | <generated>          |

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
