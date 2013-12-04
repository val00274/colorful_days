require 'colorful_days/version'
require 'colorful_days/convert'

module ColorfulDays
  module_function
  def color_distance(rgb1, rgb2)
    squared_euclidean_distance(
      ColorfulDays::Convert.rgb2lab(*rgb1),
      ColorfulDays::Convert.rgb2lab(*rgb2))
  end

  # 0 <= {r, g, b} <= 255
  def similar_rgb(r, g, b)
    color_levels.zip(colors).map {|idx, color|
      [idx, color_distance(color, [r, g, b])]
    }.min_by {|item|
      item[1]
    }.first
  end

  def colors
    color_levels.map{|a| a.map{|i| color_index_to_value(i)}}
  end

  def color_levels
    [*0..5].product([*0..5], [*0..5])
  end

  def rgb_to_index(r, g, b)
    16 + r*36 + g*6 + b
  end

  def squared_euclidean_distance(ary1, ary2)
    ary1.zip(ary2).map{|a, b| (a - b) ** 2}.reduce(&:+)
  end

  def color_index_to_value(index)
    [0x00, 0x5f, 0x87, 0xaf, 0xd7, 0xff][index]
  end

  def to_ansi_color_index(sym)
    [
      :black, :red, :green, :yellow,
      :blue, :magenta, :cyan, :white,
      :light_black, :light_red, :light_green, :light_yellow,
      :light_blue, :light_magenta, :light_cyan, :light_white,
    ].index(sym)
  end
end

class String
  def color(*param)
    case param.size
    when 1
      case param.first
      when /#?[0-9a-fA-F]{6}/
        similar_color(*param)
      when Symbol, String
        ansi(*param)
      else
        color_256(*param)
      end
    when 3
      rgb(*param)
    end
  end

  # 0..255 =~ i
  def color_256(i)
    "\033[38;5;#{i}m#{self}\033[0m"
  end

  # 0..15 =~ param 
  # [:black, :red, ...] =~ param 
  def ansi(param)
    i = case param
        when Symbol, String
          ColorfulDays.to_ansi_color_index(param.to_sym)
        when Integer
          param
        else
          raise "unknown parameter: #{param}"
        end

    color_256(i)
  end

  # 0..23 =~ i
  def gray(i)
    color_256(232 + i)
  end

  # 0..5 =~ {r, g, b}
  def rgb(r, g, b)
    color_256(ColorfulDays.rgb_to_index(r, g, b))
  end

  # [r(=0..255), g(=0..255), b(=0..255)] =~ param
  # "#RRGGBB" =~ param
  def similar_color(param)
    r, g, b = case param
              when Array
                param
              when /#?([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})/
                $~.values_at(1, 2, 3).map{|s| s.to_i(16)}
              else
                raise "unknown parameter: #{param}"
              end

    rgb(*ColorfulDays.similar_rgb(r, g, b))
  end
end

