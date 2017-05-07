require 'toml'

class People
    def initialize
        @people = TOML.load_file 'people.toml'
        puts @people
    end

    def validate name
        @people.keys.include? name
    end

    def [] name
        @people[name]
    end
end
