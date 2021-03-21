FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /aozora-api 
WORKDIR /aozora-api 
ADD Gemfile /aozora-api/Gemfile
ADD Gemfile.lock /aozora-api/Gemfile.lock
RUN gem install bundler:2.2.3
RUN bundle install
ADD . /aozora-api
