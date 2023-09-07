# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unitify/unit_groups/length"

module Unitify
  module CompositeMeasurements
    class Length
      class << self
        def parse(string)
          case string
          when M_CM_REGEX     then parse_metres_centimetres(string)
          when FT_IN_REGEX    then parse_feet_inches(string)
          when FT_IN_CM_REGEX then parse_feet_inches_centimetres(string)
          else                     raise Unitify::ParseError, string
          end
        end

        private

        def parse_metres_centimetres(string)
          metres, centimetres = string.match(M_CM_REGEX)&.captures

          if metres && centimetres
            Unitify::Length.new(metres, :m) + Unitify::Length.new(centimetres, :cm)
          end
        end

        def parse_feet_inches(string)
          feet, inches = string.match(FT_IN_REGEX)&.captures

          if feet && inches
            Unitify::Length.new(feet, :ft) + Unitify::Length.new(inches, :in)
          end
        end

        def parse_feet_inches_centimetres(string)
          feet, inches, centimetres = string.match(FT_IN_CM_REGEX)&.captures

          if feet && inches && centimetres
            Unitify::Length.new(feet, :ft) +
              Unitify::Length.new(inches, :in) +
              Unitify::Length.new(centimetres, :cm)
          end
        end
      end

      private

      FT_REGEX       = /(?:'|ft|foot|feet)/.freeze
      IN_REGEX       = /(?:"|in|inch(?:es)?)/.freeze
      M_REGEX        = /(?:m|meter(?:s)?|metre(?:s)?)/.freeze
      CM_REGEX       = /(?:cm|centimeter(?:s)?|centimetre(?:s)?)/.freeze

      FT_IN_REGEX    = /\A#{NUMBER_WITH_T_SPACES}#{FT_REGEX}#{NUMBER_WITH_LT_SPACES}#{IN_REGEX}\z/.freeze
      M_CM_REGEX     = /\A#{NUMBER_WITH_T_SPACES}#{M_REGEX}#{NUMBER_WITH_LT_SPACES}#{CM_REGEX}\z/.freeze
      FT_IN_CM_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{FT_REGEX}#{NUMBER_WITH_LT_SPACES}#{IN_REGEX}#{NUMBER_WITH_LT_SPACES}#{CM_REGEX}\z/.freeze
    end
  end
end
