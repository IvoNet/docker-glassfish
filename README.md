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