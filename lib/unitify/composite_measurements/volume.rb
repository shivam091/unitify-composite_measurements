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
          when LITRE_MILLILITRE then parse_litre_millilitre(string)
          else                       raise Unitify::ParseError, string
          end
        end

        private

        def parse_litre_millilitre(string)
          litre, millilitre = string.match(LITRE_MILLILITRE)&.captures

          if litre && millilitre
            Unitify::Volume.new(litre, :l) + Unitify::Volume.new(millilitre, :ml)
          end
        end
      end

      private

      LITRE_UNITS      = /(?:l|L|liter(?:s)?|litre(?:s)?)/.freeze
      MILLILITRE_UNITS = /(?:ml|mL|milliliter(?:s)?|millilitre(?:s)?)/.freeze

      LITRE_MILLILITRE = /\A#{NUMBER_WITH_T_SPACES}#{LITRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{MILLILITRE_UNITS}\z/.freeze
    end
  end
end
