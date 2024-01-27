FROM ruby:3.0.2-slim

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libgmp-dev \
    libpq-dev \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile* ./

RUN gem install bundler

RUN bundle install

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000
