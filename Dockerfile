FROM ruby:2.7.2-slim-buster as Ruby

##################################################
# Build Stage
##################################################
FROM Ruby as Build

ENV RACK_ENV production

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        make \
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

##################################################
# Final Stage
##################################################
FROM Ruby

ENV RACK_ENV production

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        imagemagick \
    && rm -rf /var/lib/apt/lists/*

COPY --from=Build /usr/local/bundle /usr/local/bundle
COPY --from=Build /usr/src/app /usr/src/app

WORKDIR /usr/src/app

CMD ["bundle", "exec", "rackup", "--port", "8080"]
