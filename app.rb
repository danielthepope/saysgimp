require 'sinatra'

require './generator.rb'
require './people.rb'

people = People.new
generator = Generator.new

get '/' do
    '/dan/words'
end

# get '/dan/:text' do
#     puts request.path
#     hash = Digest::MD5.new.update(request.path).hexdigest
#     output = "generated/#{hash}.jpg"
#     puts output
#     if File.file?(output)
#         puts 'returning from cache'
#     else
#         puts 'going to GIMP'
#         `gimp -i -b '(dan "#{params['text']}" "#{output}")' -b "(gimp-quit 0)"`
#         puts 'generated..?'
#     end
#     send_file output
# end

get '/:who/:text' do
    if people.validate(params['who'])
        send_file generator.get_image request.path, people[params['who']], params['text']
    else
        'Invalid person'
    end
end
