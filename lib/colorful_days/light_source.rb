require 'matrix'

module ColorfulDays
  module LightSource
    Data = Struct.new("LightSourceData", :rgb2xyz_matrix, :xyz2lab_matrix)

    module_function
    def d50
      @d50 ||= Data.new(
        Matrix[
          [0.4360747, 0.2225045, 0.0139322],
          [0.3850649, 0.7168786, 0.0971045],
          [0.1430804, 0.0606169, 0.7141733],
        ],
        Matrix.diagonal(
          0.96422, 1.00000, 0.82521,
        )
      )
    end

    def d65
      @d65 ||= Data.new(
        Matrix[
          [0.4124564, 0.2126729, 0.0193339],
          [0.3575761, 0.7151522, 0.1191920],
          [0.1804375, 0.0721750, 0.9503041],
        ],
        Matrix.diagonal(
          0.95047, 1.0000, 1.0883,
        )
      )
    end
  end
end

