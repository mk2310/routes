FROM ruby:2.4.0-slim

RUN apt update && apt install -qq -y --no-install-recommends \
    build-essential nodejs libpq-dev git git-core libsqlite3-dev

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle 

ADD . $APP_HOME
