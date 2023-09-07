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
          when METRES_CENTIMETRES_REGEX      then parse_metres_centimetres(string)
          when FEET_INCHES_REGEX             then parse_feet_inches(string)
          when FEET_INCHES_CENTIMETRES_REGEX then parse_feet_inches_centimetres(string)
          else                                    raise Unitify::ParseError, string
          end
        end

        private

        def parse_metres_centimetres(string)
          metres, centimetres = string.match(METRES_CENTIMETRES_REGEX)&.captures

          if metres && centimetres
            Unitify::Length.new(metres, :m) + Unitify::Length.new(centimetres, :cm)
          end
        end

        def parse_feet_inches(string)
          feet, inches = string.match(FEET_INCHES_REGEX)&.captures

          if feet && inches
            Unitify::Length.new(feet, :ft) + Unitify::Length.new(inches, :in)
          end
        end

        def parse_feet_inches_centimetres(string)
          feet, inches, centimetres = string.match(FEET_INCHES_CENTIMETRES_REGEX)&.captures

          if feet && inches && centimetres
            Unitify::Length.new(feet, :ft) +
              Unitify::Length.new(inches, :in) +
              Unitify::Length.new(centimetres, :cm)
          end
        end
      end

      private

      FEET_UNIT_REGEX        = /(?:'|ft|foot|feet)/.freeze
      INCHES_UNIT_REGEX      = /(?:"|in|inch(?:es)?)/.freeze
      METRES_UNIT_REGEX      = /(?:m|meter(?:s)?|metre(?:s)?)/.freeze
      CENTIMETRES_UNIT_REGEX = /(?:cm|centimeter(?:s)?|centimetre(?:s)?)/.freeze

      FEET_INCHES_REGEX             = /\A#{NUMBER_WITH_T_SPACES}#{FEET_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{INCHES_UNIT_REGEX}\z/.freeze
      METRES_CENTIMETRES_REGEX      = /\A#{NUMBER_WITH_T_SPACES}#{METRES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{CENTIMETRES_UNIT_REGEX}\z/.freeze
      FEET_INCHES_CENTIMETRES_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{FEET_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{INCHES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{CENTIMETRES_UNIT_REGEX}\z/.freeze
    end
  end
end
