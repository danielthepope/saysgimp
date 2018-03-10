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
        base_image = "public/images/#{person['image']}"
        return base_image if text.strip == ''
        text = add_newlines(text, person['widescreen'] ? 20 : 15)
        x1 = person['screen'][0]
        y1 = person['screen'][1]
        x2 = person['screen'][2]
        y2 = person['screen'][3]
        x3 = person['screen'][4]
        y3 = person['screen'][5]
        x4 = person['screen'][6]
        y4 = person['screen'][7]
        dark_file = "overlays/#{person['overlay_dark']}"
        light_file = "overlays/#{person['overlay_light']}"
        screen_width = person['widescreen'] ? 960 : 720
        screen_height = 540

        system('gimp', '-i', '-b',
        %Q'(says "#{base_image}" "#{output}" "#{sanitize(text)}" "#{dark_file}" "#{light_file}" #{screen_width} #{screen_height} #{x1} #{y1} #{x2} #{y2} #{x3} #{y3} #{x4} #{y4})',
        '-b', '(gimp-quit 0)')

        File.file?(output) ? output : base_image
    end

    def sanitize text
        text.gsub(/\\/, '\\\\\\\\')
            .gsub(/"/, '\\"')
    end

    def add_newlines text, char_target
        charcount = 0
        output = ''
        text.split(/ /).each do |word|
            if charcount + word.length > char_target
                output += "\n#{word}"
                charcount = word.length
            else
                output += " #{word}"
                charcount += word.length
            end
        end
        output.strip
    end
end
