# Says

Another copy of the JSOxford in-joke, where you can make people present whatever you want.

This version uses Ruby with Sinatra, and the images are generated using [GIMP](https://www.gimp.org/)'s batch mode.

![Dan says "I approve this message"](http://says.danielthepope.co.uk/Dan?text=I%20approve%20this%20message)

## Setup

First install GIMP. On Ubuntu this was as simple as `sudo apt install gimp`. Other systems may be different. Essentially the outcome of this is you need to be able to see the `gimp` command in your terminal.

```
$ gimp -v
GNU Image Manipulation Program version 2.8.16
```

Run `./setup.sh`, which does the following:

- Copy `says-gimp.scm` to `~/.gimp-2.8/scripts`
- Install Ruby dependencies with `bundle install`

## Running

```
bundle exec rackup --host 0.0.0.0 -p 4567
```

Or, use the handy `./run` script, which does the same thing.
