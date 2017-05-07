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
        puts 'going to GIMP'
        done = `gimp -i -b '(dan "#{params['text']}" "#{output}")' -b "(gimp-quit 0)"`
        puts "Done: #{done}"
    else
        puts 'returning from cache'
    end
    send_file output
end

__END__

GIMP needs to
- Load base file
- Create text layer with specified colour
- Convert text to raster
- Transform text to screen