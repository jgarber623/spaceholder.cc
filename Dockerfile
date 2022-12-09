################################################################################
# Base Stage
################################################################################
FROM ruby:3.1.3-alpine3.17 AS base-stage

ENV BUNDLE_JOBS=10 \
    BUNDLE_RETRIES=5

EXPOSE 8080

RUN apk add --no-cache --update graphicsmagick

RUN echo "gem: --no-document" >> ~/.gemrc

WORKDIR /usr/src/app

################################################################################
# Development
################################################################################
FROM base-stage AS development

ENV RACK_ENV=development \
    BUNDLE_PATH=/usr/src/dependencies/bundler

RUN apk add --no-cache --update g++ git make

RUN mkdir -p /usr/src/dependencies

VOLUME /usr/src/dependencies

COPY Gemfile Gemfile.lock ./

RUN bundle install

################################################################################
# Production Build Stage
################################################################################
FROM base-stage AS production-build-stage

ENV RACK_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test

RUN apk add --no-cache --update g++ make

COPY Gemfile Gemfile.lock ./

RUN bundle install \
    && bundle clean --force \
    && rm -rf vendor/bundle/ruby/3.1.0/cache/*.gem \
    && find vendor/bundle/ruby/3.1.0/gems/ \( -name "*.c" -o -name "*.o" \) -delete

COPY . .

RUN bundle exec rake assets:precompile

################################################################################
# Production
################################################################################
FROM base-stage AS production

ENV RACK_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test

COPY --from=production-build-stage /usr/src/app ./

CMD ["bundle", "exec", "puma", "--config", "config/puma.rb"]
