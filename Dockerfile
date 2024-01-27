FROM ruby:3.0.2-slim

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update && apt-get install -y \
    build-essential \
    libgmp-dev \
    libpq-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN bundle install

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]