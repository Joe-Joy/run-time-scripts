```yml

# vim docker-compose.yml
version: "3"
services:
  database:
    image: mysql:5.7
    networks:
      - wordpress
    volumes:
    - wordpress:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: somewordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
  wordpress:
    image: wordpress
    depends_on:
    - database
    ports:
    - "8080:80"
    restart: always
    networks:
      - wordpress
    environment:
      WORDPRESS_DB_HOST: database:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
networks:
  wordpress:
    driver: bridge
volumes:
  wordpress:

```
