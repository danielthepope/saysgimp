require 'securerandom'
require 'sinatra'
require 'toml'


people = TOML.load_file('people.toml')
output = SecureRandom.uuid + '.jpg'
puts output


__END__

GIMP needs to
- Load base file
- Create text layer with specified colour
- Convert text to raster
- Transform text to screen