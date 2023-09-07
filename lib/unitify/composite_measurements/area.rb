# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unitify/unit_groups/area"

module Unitify
  module CompositeMeasurements
    class Area
      class << self
        def parse(string)
          case string
          when ACRES_SQ_METRES_REGEX   then parse_acres_sq_metres(string)
          when SQ_FEET_SQ_INCHES_REGEX then parse_sq_feet_sq_inches(string)
          when SQ_FEET_SQ_METRES_REGEX then parse_sq_feet_sq_metres(string)
          else                              raise Unitify::ParseError, string
          end
        end

        private

        def parse_acres_sq_metres(string)
          acres, sq_metres = string.match(ACRES_SQ_METRES_REGEX)&.captures

          if acres && sq_metres
            Unitify::Area.new(acres, :ac) + Unitify::Area.new(sq_metres, :m²)
          end
        end

        def parse_sq_feet_sq_inches(string)
          sq_feet, sq_inches = string.match(SQ_FEET_SQ_INCHES_REGEX)&.captures

          if sq_feet && sq_inches
            Unitify::Area.new(sq_feet, :ft²) + Unitify::Area.new(sq_inches, :in²)
          end
        end

        def parse_sq_feet_sq_metres(string)
          sq_feet, sq_metres = string.match(SQ_FEET_SQ_METRES_REGEX)&.captures

          if sq_feet && sq_metres
            Unitify::Area.new(sq_feet, :ft²) + Unitify::Area.new(sq_metres, :m²)
          end
        end
      end

      private

      ACRES_UNIT_REGEX     = /(?:ac|acre(?:s)?)/.freeze
      SQ_METRES_UNIT_REGEX = /(?:m²|m2|m\^2|m\*m|sq m|square meter(?:s)?|square metre(?:s)?)/.freeze
      SQ_FEET_UNIT_REGEX   = /(?:ft²|ft2|ft\^2|ft\*ft|sq ft|square foot|square feet)/.freeze
      SQ_INCHES_UNIT_REGEX = /(?:in²|in2|in\^2|in\*in|sq in|square inch(?:es)?)/.freeze

      ACRES_SQ_METRES_REGEX   = /\A#{NUMBER_WITH_T_SPACES}#{ACRES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{SQ_METRES_UNIT_REGEX}\z/.freeze
      SQ_FEET_SQ_INCHES_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{SQ_FEET_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{SQ_INCHES_UNIT_REGEX}\z/.freeze
      SQ_FEET_SQ_METRES_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{SQ_FEET_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{SQ_METRES_UNIT_REGEX}\z/.freeze
    end
  end
end
