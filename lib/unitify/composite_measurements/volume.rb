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
          when LITRES_MILLILITRES_REGEX then parse_litres_millilitres(string)
          else                               raise Unitify::ParseError, string
          end
        end

        private

        def parse_litres_millilitres(string)
          litre, millilitres = string.match(LITRES_MILLILITRES_REGEX)&.captures

          if litre && millilitres
            Unitify::Volume.new(litre, :l) + Unitify::Volume.new(millilitres, :ml)
          end
        end
      end

      private

      LITRES_UNIT_REGEX      = /(?:l|L|liter(?:s)?|litre(?:s)?)/.freeze
      MILLILITRES_UNIT_REGEX = /(?:ml|mL|milliliter(?:s)?|millilitre(?:s)?)/.freeze

      LITRES_MILLILITRES_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{LITRES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{MILLILITRES_UNIT_REGEX}\z/.freeze
    end
  end
end
