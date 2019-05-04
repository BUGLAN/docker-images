# talk is cheap, show me the code

- [nginx](nginx/Dockerfile): nginx dockerfile

- [tor]: docker run tor image

dockerfile:
```bash

```


run:
```bash
docker run -d -p 8118:8118 -p 9050:9050 rdsubhas/tor-privoxy-alpine
```

- [mysql 5.7]: docker run mysql 5.7

```bash
docker run -d --name mysql -p 127.0.0.1:3306:3306 -v ~/.mysql/date:/var/lib/mysql -e MYSQL_ROOT_PASSWORD="root" mysql:5.7
```