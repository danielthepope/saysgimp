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

    def all
        @people.keys.map do |person|
            {
                :name => person.capitalize,
                :image => "images/#{@people[person]['image']}"
            }
        end
    end
end
