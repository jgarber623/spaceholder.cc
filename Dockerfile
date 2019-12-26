FROM ruby:2.6.5-slim-stretch

ENV RACK_ENV production

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        imagemagick \
        make \
    && rm -rf /var/lib/apt/lists/* \
    && gem install bundler -v 2.0.2 \
    && bundle config --global frozen true

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --no-cache --without development test \
    && bundle clean --force \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . .

RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "rackup", "--port", "8080"]
