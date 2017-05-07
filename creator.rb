require 'digest'
require 'fileutils'
require 'securerandom'
require 'sinatra'
require 'toml'

FileUtils.mkdir_p 'generated'

people = TOML.load_file('people.toml')

get '/' do
    '/dan/words'
end

get '/dan/:text' do
    puts request.path
    hash = Digest::MD5.new.update(request.path).hexdigest
    output = "generated/#{hash}.jpg"
    puts output
    if File.file?(output)
        puts 'returning from cache'
    else
        puts 'going to GIMP'
        `gimp -i -b '(dan "#{params['text']}" "#{output}")' -b "(gimp-quit 0)"`
        puts 'generated..?'
    end
    send_file output
end
