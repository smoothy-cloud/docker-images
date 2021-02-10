# PHP-FPM Docker image

## Usage

```
docker run smoothy/php-fpm:7.4
```

## User

The image is configured to run as the unprivileged user `smoothy`, which has a uid of 1000.

## Port

Since the image is configured the run as an unprivileged user, PHP-FPM can only listen to ports higher than 1024.

## Configuration

You can set the following environment variables to tweak the PHP configuration to your needs.

| Variable | Description |
|---|---|
| `TIMEZONE` | Configure the timezone of both the Linux kernel as well as PHP. The default value is UTC. |
| `MAX_FILE_UPLOAD` | Configure the maximum allowed size for file uploads in Megabytes. The default value is 2MB. |
| `OPCACHE` | Enable or disable PHP OPcache. The default value is 0. |

## Entrypoints

Sometimes you may want to run a Shell script to tweak the PHP configuration right before PHP is started. To do so, you can copy your own Shell script into the `/entrypoints/` directory.

Example:

```dockerfile
COPY start.sh /entrypoints/start.sh
```