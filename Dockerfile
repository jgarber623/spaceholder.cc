FROM ruby:2.7.4-alpine as ruby-stage

##################################################
# Build Stage
##################################################
FROM ruby-stage as build-stage

ENV RACK_ENV production

RUN apk add --no-cache \
        g++ \
        make \
    && bundle config --global frozen true \
    && bundle config --global without "development test"

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
FROM ruby-stage

ENV RACK_ENV production

RUN apk add --no-cache imagemagick

COPY --from=build-stage /usr/local/bundle /usr/local/bundle
COPY --from=build-stage /usr/src/app /usr/src/app

WORKDIR /usr/src/app

CMD ["bundle", "exec", "rackup", "--port", "8080"]
