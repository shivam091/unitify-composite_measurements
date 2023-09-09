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
          when LITRE_MILLILITRE       then parse_litre_millilitre(string)
          when CU_METRE_CU_CENTIMETRE then parse_cu_metre_cu_centimetre(string)
          else                             raise Unitify::ParseError, string
          end
        end

        private

        def parse_litre_millilitre(string)
          litre, millilitre = string.match(LITRE_MILLILITRE)&.captures

          if litre && millilitre
            Unitify::Volume.new(litre, :l) + Unitify::Volume.new(millilitre, :ml)
          end
        end

        def parse_cu_metre_cu_centimetre(string)
          cu_metre, cu_centimetre = string.match(CU_METRE_CU_CENTIMETRE)&.captures

          if cu_metre && cu_centimetre
            Unitify::Volume.new(cu_metre, :m³) + Unitify::Volume.new(cu_centimetre, :cm³)
          end
        end
      end

      private

      LITRE_UNITS         = /(?:l|L|liter(?:s)?|litre(?:s)?)/.freeze
      MILLILITRE_UNITS    = /(?:ml|mL|milliliter(?:s)?|millilitre(?:s)?)/.freeze
      CU_METRE_UNITS      = /(?:m³|m3|m\^3|m\*m\*m|cubic meter(?:s)?|cubic metre(?:s)?)/.freeze
      CU_CENTIMETRE_UNITS = /(?:cm³|cm3|cm\^3|cm\*cm\*cm|cubic centimeter(?:s)?|cubic centimetre(?:s)?)/.freeze

      LITRE_MILLILITRE       = /\A#{NUMBER_WITH_T_SPACES}#{LITRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{MILLILITRE_UNITS}\z/.freeze
      CU_METRE_CU_CENTIMETRE = /\A#{NUMBER_WITH_T_SPACES}#{CU_METRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{CU_CENTIMETRE_UNITS}\z/.freeze
    end
  end
end
