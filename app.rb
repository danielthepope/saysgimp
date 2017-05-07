require 'sinatra'

require './generator.rb'
require './people.rb'

people = People.new
generator = Generator.new

get '/' do
    erb :index, :locals => { :people => people.all }
end

get '/:who' do
    person = params['who'].downcase
    text = params['text'].gsub(/[\\]/, '\\\\\\\\').gsub(/[']/, '\\\\\'').gsub(/["]/, '\\"')
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
