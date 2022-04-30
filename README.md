# Glassfish application server

Glassfish docker image with admin panel enabled

## Usage

```shell
docker run \
  -d \
  --name glassfish \
  -p 8080:8080 \
  -p 4848:4848 \
  ivonet/glassfish
```

Default (official build) `username/password` for the [admin](http://localhost:4848) panel is `admin/admin123`


## Build

Creator:

```shell
make ARG="--build-arg PASSWORD=admin123" glassfish
```

User:

```shell
docker build [--build-arg PASSWORD=<GLASSFISH_ADMIN_PASSWORD_HERE>] -t [HANDLE/]<IMAGE>[:TAG] .
```

Basic:

```shell
docker build -t glassfish .
```

if you do not provide `--build-arg PASSWORD=<GLASSFISH_ADMIN_PASSWORD_HERE>` in the build the username/password will be `admin/secret`
