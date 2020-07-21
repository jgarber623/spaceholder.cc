FROM ruby:2.6.6-slim-stretch

ENV RACK_ENV production

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        imagemagick \
        make \
    && rm -rf /var/lib/apt/lists/* \
    && gem install bundler -v 2.0.2 \
    && bundle config --global frozen true \
    && bundle config --global no-cache 'true' \
    && bundle config --global without 'development test'

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install \
    && bundle clean --force \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . .

RUN bundle exec rake assets:precompile

CMD ["bundle", "exec", "rackup", "--port", "8080"]
