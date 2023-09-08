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
          when ACRE_SQ_METRE    then parse_acre_sq_metre(string)
          when SQ_FOOT_SQ_INCH  then parse_sq_foot_sq_inch(string)
          when SQ_FOOT_SQ_METRE then parse_sq_foot_sq_metre(string)
          else                       raise Unitify::ParseError, string
          end
        end

        private

        def parse_acre_sq_metre(string)
          acre, sq_metre = string.match(ACRE_SQ_METRE)&.captures

          if acre && sq_metre
            Unitify::Area.new(acre, :ac) + Unitify::Area.new(sq_metre, :m²)
          end
        end

        def parse_sq_foot_sq_inch(string)
          sq_foot, sq_inch = string.match(SQ_FOOT_SQ_INCH)&.captures

          if sq_foot && sq_inch
            Unitify::Area.new(sq_foot, :ft²) + Unitify::Area.new(sq_inch, :in²)
          end
        end

        def parse_sq_foot_sq_metre(string)
          sq_foot, sq_metres = string.match(SQ_FOOT_SQ_METRE)&.captures

          if sq_foot && sq_metres
            Unitify::Area.new(sq_foot, :ft²) + Unitify::Area.new(sq_metres, :m²)
          end
        end
      end

      private

      ACRE_UNITS     = /(?:ac|acre(?:s)?)/.freeze
      SQ_METRE_UNITS = /(?:m²|m2|m\^2|m\*m|sq m|square meter(?:s)?|square metre(?:s)?)/.freeze
      SQ_FOOT_UNITS  = /(?:ft²|ft2|ft\^2|ft\*ft|sq ft|square foot|square feet)/.freeze
      SQ_INCH_UNITS  = /(?:in²|in2|in\^2|in\*in|sq in|square inch(?:es)?)/.freeze

      ACRE_SQ_METRE    = /\A#{NUMBER_WITH_T_SPACES}#{ACRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{SQ_METRE_UNITS}\z/.freeze
      SQ_FOOT_SQ_INCH  = /\A#{NUMBER_WITH_T_SPACES}#{SQ_FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{SQ_INCH_UNITS}\z/.freeze
      SQ_FOOT_SQ_METRE = /\A#{NUMBER_WITH_T_SPACES}#{SQ_FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{SQ_METRE_UNITS}\z/.freeze
    end
  end
end
