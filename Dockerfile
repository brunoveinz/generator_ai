#define image base
ARG RUBY_VERSION=3.0.2
FROM ruby:$RUBY_VERSION

ENV BUNDLER_VERSION 2.4.8
ENV APP_HOME /usr/src/app

#install libvips for active storage preview support
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata postgresql nodejs npm yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

#rails app live here
WORKDIR $APP_HOME

#install aplication gems
COPY Gemfile* $APP_HOME
RUN bundle install 

#precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

RUN gem install rake \
   && gem install rubygems-bundler \
   && gem install bundler -v $BUNDLER_VERSION \
   && bundle update -j 4 \
   && gem install bcrypt --platform=ruby \
   && bundle install \
   && bundle check || bundle update

#copy application code
COPY . $APP_HOME

#copy entrypoint into container and give permission 
COPY entrypoint.sh /rails/bin/entrypoint.sh
RUN chmod +x /rails/bin/entrypoint.sh

#Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

#entrypoint
ENTRYPOINT ["/rails/bin/entrypoint.sh"]
    
# Start the server by default, this can be overwritten at runtime
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]