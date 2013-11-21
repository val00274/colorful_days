require 'matrix'
require_relative './light_source'

module ColorfulDays
  module Convert
    module_function
    def light_source
      ColorfulDays::LightSource.d50
    end

    # 0 <= {r, g, b} <= 1
    def rgb2lab(r, g, b)
      xyz2lab(rgb2xyz(Matrix[[r, g, b]]))
    end

    def gamma_collecting(m)
      m.map {|n|
        if n < 0.04045
          n / 12.92
        else
          ((n + 0.055) / 1.055) ** 2.4
        end
      }
    end

    def rgb2xyz(rgb)
      gamma_collecting(rgb) * light_source.rgb2xyz_matrix
    end

    def xyz2lab(xyz)
      x, y, z = (
        xyz * light_source.xyz2lab_matrix
      ).map{|n|
        if n > 0.008856
          n ** (1.0/3.0)
        else
          (7.787 * n) + (16.0 / 116.0)
        end
      }.to_a.flatten

      [
        (116 * y) - 16,
        500 * (x - y),
        200 * (y - z),
      ]
    end
  end
end

