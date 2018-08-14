require 'sinatra/base'

require_relative 'generator'
require_relative 'people'

class App < Sinatra::Base
  set :bind, "0.0.0.0"

  people = People.new
  generator = Generator.new

  get '/' do
      erb :index, :locals => { :people => people.all }
  end

  get '/:who' do
      person = params['who'].downcase
      text = params['text']
      puts text
      puts request.path
      puts person
      puts text
      if people.validate(person)
          send_file generator.get_image "/#{person}/#{text}", people[person], text
      else
          'Invalid person'
      end
  end
end
