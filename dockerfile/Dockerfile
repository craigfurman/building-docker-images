FROM ruby:2.3.1-alpine
COPY app/* ./
RUN bundle install
CMD bundle exec ruby app.rb
