require 'digest'
require 'fileutils'
require 'securerandom'

class Generator
    def initialize
        FileUtils.mkdir_p 'generated'
    end

    def get_image request_path, person, text
        output = hash_filename request_path
        if File.file? output
            output
        else
            generate_image person, text, output
        end
    end

    private

    def hash_filename path
        hash = Digest::MD5.new.update(path).hexdigest
        "generated/#{hash}.jpg"
    end

    def generate_image person, text, output
        base_image = "images/#{person['image']}"
        x1 = person['screen'][0]
        y1 = person['screen'][1]
        x2 = person['screen'][2]
        y2 = person['screen'][3]
        x3 = person['screen'][4]
        y3 = person['screen'][5]
        x4 = person['screen'][6]
        y4 = person['screen'][7]
        red = person['text_colour'][0]
        green = person['text_colour'][1]
        blue = person['text_colour'][2]
        screen_width = person['widescreen'] ? 960 : 720
        screen_height = 540

        #(says input-image output-image words black-red black-green black-blue screen-width screen-height x1 y1 x2 y2 x3 y3 x4 y4)
        `gimp -i -b '(says "#{base_image}" "#{output}" \
            "#{text}" #{red} #{green} #{blue} #{screen_width} #{screen_height} \
            #{x1} #{y1} #{x2} #{y2} #{x3} #{y3} #{x4} #{y4} \
            )' -b "(gimp-quit 0)"`

        output
    end
end
