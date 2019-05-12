FROM ruby:2.6.3-slim-stretch

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        imagemagick \
        make \
    && rm -rf /var/lib/apt/lists/* \
    && gem update --system \
    && gem install bundler \
    && bundle config --global frozen true

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --without development test

COPY . .

ENV RACK_ENV production

RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "rackup", "--port", "8080"]
