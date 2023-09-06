# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unitify/unit_groups/volume"

module Unitify
  module CompositeMeasurements
    class Volume
      class << self
        def parse(string)
          case string
          when L_ML_REGEX then parse_l_ml(string)
          else                 raise Unitify::ParseError, string
          end
        end

        private

        def parse_l_ml(string)
          litre, millilitres = string.match(L_ML_REGEX)&.captures

          if litre && millilitres
            Unitify::Volume.new(litre, :l) + Unitify::Volume.new(millilitres, :ml)
          end
        end
      end

      private

      L_REGEX    = /(?:l|L|liter(?:s)?|litre(?:s)?)/.freeze
      ML_REGEX   = /(?:ml|mL|milliliter(?:s)?|millilitre(?:s)?)/.freeze

      L_ML_REGEX = /\A#{ANY_DIGIT_WITH_T_SPACES}#{L_REGEX}#{ANY_DIGIT_WITH_LT_SPACES}#{ML_REGEX}\z/.freeze
    end
  end
end
