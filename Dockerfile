FROM ruby:2.5

ENV RAILS_ENV=production
RUN apt-get update -qq && apt-get install -y build-essential mysql-client nodejs
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

CMD bin/rails server --binding=0.0.0.0 --port=3000
