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

RUN bundle install

COPY . .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
