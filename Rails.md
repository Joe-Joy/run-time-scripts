```bash
 git clone https://github.com/spritlesoftware/sample-rails6-app.git
 cd sample-rails6-app
 
 sudo apt update
 sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
 
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
 echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 
 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io -y
 sudo usermod -a -G docker $USER

 sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
 sudo chmod +x /usr/local/bin/docker-compose

```



```Dockerfile

FROM ruby:2.6.0
RUN apt-get update -qq && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn git postgresql-client build-essential patch ruby-dev zlib1g-dev liblzma-dev 
RUN gem install nokogiri
RUN gem install bundler
#RUN git clone https://github.com/spritlesoftware/sample-rails6-app
WORKDIR /sample-rails6-app
COPY . . 
RUN bundle update
RUN bundle install
RUN yarn install
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
```

```docker-compose

version: '3.5'
services:
  postgres:
    image: postgres:11-alpine
    container_name: postgres
    volumes:
      - postgres-datastore:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    environment:
      POSTGRES_DB: sample_rails6_app_development
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: changeme
    networks:
      - rails-net
  ralis-app:
    build:
      context: .
    #image: vijayrajan23/rails:v4
    container_name: rails-app
    ports:
      - 3000:3000
    networks:
      - rails-net
    restart: unless-stopped
    depends_on:
      - 'postgres'
networks:
  rails-net:
    driver: bridge   
volumes:
  postgres-datastore:

```



```yml
# vim config/database.yml 
# PostgreSQL. Versions 9.3 and up are supported.
#
# Install the pg driver:
#   gem install pg
# On macOS with Homebrew:
#   gem install pg -- --with-pg-config=/usr/local/bin/pg_config
# On macOS with MacPorts:
#   gem install pg -- --with-pg-config=/opt/local/lib/postgresql84/bin/pg_config
# On Windows:
#   gem install pg
#       Choose the win32 build.
#       Install PostgreSQL and put its /bin directory on your path.
#
# Configure Using Gemfile
# gem 'pg'
#
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: sample_rails6_app_development

  # The specified database role being used to connect to postgres.
  # To create additional roles in postgres see `$ createuser --help`.
  # When left blank, postgres will use the default role. This is
  # the same name as the operating system user that initialized the database.
  username: postgres

  # The password associated with the postgres role (username).
  password: changeme

  # Connect on a TCP socket. Omitted by default since the client uses a
  # domain socket that doesn't need configuration. Windows does not have
  # domain sockets, so uncomment these lines.
  host: postgres

  # The TCP port the server listens on. Defaults to 5432.
  # If your server runs on a different port number, change accordingly.
  port: 5432

  # Schema search path. The server defaults to $user,public
  #schema_search_path: myapp,sharedapp,public

  # Minimum log levels, in increasing order:
  #   debug5, debug4, debug3, debug2, debug1,
  #   log, notice, warning, error, fatal, and panic
  # Defaults to warning.
  #min_messages: notice

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: sample_rails6_app_test
  username: postgres
  password: changeme
  host: postgres
  port: 5432

# As with config/credentials.yml, you never want to store sensitive information,
# like your database password, in your source code. If your source code is
# ever seen by anyone, they now have access to your database.
#
# Instead, provide the password as a unix environment variable when you boot
# the app. Read https://guides.rubyonrails.org/configuring.html#configuring-a-database
# for a full rundown on how to provide these environment variables in a
# production deployment.
#
# On Heroku and other platform providers, you may have a full connection URL
# available as an environment variable. For example:
#
#   DATABASE_URL="postgres://myuser:mypass@localhost/somedatabase"
#
# You can use this database configuration with:
#
#   production:
#     url: <%= ENV['DATABASE_URL'] %>
#
production:
  <<: *default
  database: sample_rails6_app_production
  username: postgres
  password: changeme
  host: postgres
  port: 5432

```

```bash

docker-compose up -d
docker exec -ti rails-app bash
rake db:create
exit

```

```bash

open your browser => xxx.xxx.xxx.xxx:3000

http://3.85.102.254:3000/


```
