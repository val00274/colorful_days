# ColorfulDays

ターミナル上で文字色を変更. (256色terminal限定)

## Installation

Add this line to your application's Gemfile:

    gem 'colorful_days'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install colorful_days

## Usage

```
require 'colorful_days'

puts "foo".color(1) # red (color index)
puts "foo".color(:green) # green (named color)
puts "foo".color(5, 0, 2) # pink (RGB(6x6x6))
puts "foo".gray(5) # dark gray (gray color:0-23)
puts "foo".color("#f3a68c") # salmon pink (similar color)
```

- color index
  - 0-15 : system color
  - 16-231 : RGB color
  - 232-255 : gray color

- named colors
  - :black
  - :red
  - :green
  - :yellow,
  - :blue
  - :magenta
  - :cyan
  - :white,
  - :light_black
  - :light_red
  - :light_green
  - :light_yellow,
  - :light_blue
  - :light_magenta
  - :light_cyan
  - :light_white,

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
