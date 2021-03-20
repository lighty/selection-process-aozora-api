FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /aozora-api 
WORKDIR /aozora-api 
ADD Gemfile /aozora-api/Gemfile
ADD Gemfile.lock /aozora-api/Gemfile.lock
RUN bundle install
ADD . /aozora-api
