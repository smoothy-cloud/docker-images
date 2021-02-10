# NGINX Docker image

## Usage

```
docker run --tty smoothy/nginx-1.19
```

## User

The image is configured to run as the unprivileged user `smoothy`, which has a uid of 1000.

## Port

Since the image is configured the run as an unprivileged user, NGINX can only listen to ports higher than 1024.

## Configuration

You can set the following environment variables to tweak the NGINX configuration to your needs.

| Variable | Description |
|---|---|
| `MAX_FILE_UPLOAD` | Configure the maximum allowed size for file uploads in Megabytes. The default value is 2MB. |

## Server blocks

The image only provides a basic configuration for NGINX. You still have to add your own server configuration. You can do this by copying one or more `.conf` files into the `/etc/nginx/conf.d/` directory.

Example:

```dockerfile
COPY server.conf /etc/nginx/conf.d/server.conf
```

## Entrypoints

Sometimes you may want to run a Shell script to tweak the NGINX configuration right before NGINX is started. To do so, you can copy your own Shell script into the `/entrypoints/` directory.

Example:

```dockerfile
COPY start.sh /entrypoints/start.sh
```