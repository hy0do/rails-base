FROM node:15.9.0 as node
FROM ruby:2.7.2

ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    less \
    vim \
    libfontconfig1 && \
    rm -rf /var/lib/apt/lists/*

# node
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# yarn 
ENV YARN_VERSION 1.22.5
COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg
RUN yarn install --check-files

# bundler
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle config build.nokogiri --use-system-libraries

RUN mkdir /app
