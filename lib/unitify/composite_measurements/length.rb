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
          when METRE_CENTIMETRE     then parse_metre_centimetre(string)
          when FOOT_INCH            then parse_foot_inch(string)
          when MILE_YARD            then parse_mile_yard(string)
          when KILOMETRE_METRE      then parse_kilometre_metre(string)
          when MILE_YARD_FOOT       then parse_mile_yard_foot(string)
          when FOOT_INCH_CENTIMETRE then parse_foot_inch_centimetre(string)
          else                           raise Unitify::ParseError, string
          end
        end

        private

        def parse_metre_centimetre(string)
          metre, centimetre = string.match(METRE_CENTIMETRE)&.captures

          if metre && centimetre
            Unitify::Length.new(metre, :m) + Unitify::Length.new(centimetre, :cm)
          end
        end

        def parse_foot_inch(string)
          foot, inch = string.match(FOOT_INCH)&.captures

          if foot && inch
            Unitify::Length.new(foot, :ft) + Unitify::Length.new(inch, :in)
          end
        end

        def parse_mile_yard(string)
          mile, yard = string.match(MILE_YARD)&.captures

          if mile && yard
            Unitify::Length.new(mile, :mi) + Unitify::Length.new(yard, :yd)
          end
        end

        def parse_kilometre_metre(string)
          kilometre, metre = string.match(KILOMETRE_METRE)&.captures

          if kilometre && metre
            Unitify::Length.new(kilometre, :km) + Unitify::Length.new(metre, :m)
          end
        end

        def parse_mile_yard_foot(string)
          mile, yard, foot = string.match(MILE_YARD_FOOT)&.captures

          if mile && yard && foot
            Unitify::Length.new(mile, :mi) +
              Unitify::Length.new(yard, :yd) +
              Unitify::Length.new(foot, :feet)
          end
        end

        def parse_foot_inch_centimetre(string)
          foot, inch, centimetre = string.match(FOOT_INCH_CENTIMETRE)&.captures

          if foot && inch && centimetre
            Unitify::Length.new(foot, :ft) +
              Unitify::Length.new(inch, :in) +
              Unitify::Length.new(centimetre, :cm)
          end
        end
      end

      private

      FOOT_UNITS       = /(?:'|ft|foot|feet)/.freeze
      INCH_UNITS       = /(?:"|in|inch(?:es)?)/.freeze
      METRE_UNITS      = /(?:m|meter(?:s)?|metre(?:s)?)/.freeze
      CENTIMETRE_UNITS = /(?:cm|centimeter(?:s)?|centimetre(?:s)?)/.freeze
      KILOMETRE_UNITS  = /(?:km|kilometer(?:s)?|kilometre(?:s)?)/.freeze
      MILE_UNITS       = /(?:mi|mile(?:s)?)/.freeze
      YARD_UNITS       = /(?:yd|yard(?:s)?)/.freeze

      FOOT_INCH            = /\A#{NUMBER_WITH_T_SPACES}#{FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{INCH_UNITS}\z/.freeze
      METRE_CENTIMETRE     = /\A#{NUMBER_WITH_T_SPACES}#{METRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{CENTIMETRE_UNITS}\z/.freeze
      MILE_YARD            = /\A#{NUMBER_WITH_T_SPACES}#{MILE_UNITS}#{NUMBER_WITH_LT_SPACES}#{YARD_UNITS}\z/.freeze
      KILOMETRE_METRE      = /\A#{NUMBER_WITH_T_SPACES}#{KILOMETRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{METRE_UNITS}\z/.freeze
      MILE_YARD_FOOT       = /\A#{NUMBER_WITH_T_SPACES}#{MILE_UNITS}#{NUMBER_WITH_LT_SPACES}#{YARD_UNITS}#{NUMBER_WITH_LT_SPACES}#{FOOT_UNITS}\z/.freeze
      FOOT_INCH_CENTIMETRE = /\A#{NUMBER_WITH_T_SPACES}#{FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{INCH_UNITS}#{NUMBER_WITH_LT_SPACES}#{CENTIMETRE_UNITS}\z/.freeze
    end
  end
end
