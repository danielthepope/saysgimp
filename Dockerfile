#FROM ruby:2.3
FROM ruby:2.3-alpine
RUN apk add --no-cache --update gimp ghostscript-fonts
#RUN apt install gimp ghostscript-fonts
RUN apk add --no-cache --update bash
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . ./
RUN ./setup.sh
#EXPOSE 4567
#ENTRYPOINT ["ruby", "app.rb"]
EXPOSE 4567
#CMD ["bash"]
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
