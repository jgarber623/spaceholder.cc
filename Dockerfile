FROM ruby:2.5.1

ARG VIPS_VERSION=8.6.3

RUN apt-get update && apt-get install -y \
      libexpat1-dev \
      libglib2.0-dev \
      libgsf-1-dev \
      libjpeg62-turbo-dev \
      libtiff5-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl -sSL https://github.com/jcupitt/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz | tar -xzf - && \
    cd vips-${VIPS_VERSION} && \
    ./configure && \
    make && \
    make install && \
    ldconfig && \
    cd .. && \
    rm -rf vips-${VIPS_VERSION}

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 20 --retry 5

EXPOSE 9393

CMD ["bin/shotgun", "--host", "0.0.0.0"]
