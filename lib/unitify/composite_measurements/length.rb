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
          when METRE_CENTIMETRE           then parse_metre_centimetre(string)
          when FOOT_INCH                  then parse_foot_inch(string)
          when MILE_YARD                  then parse_mile_yard(string)
          when KILOMETRE_METRE            then parse_kilometre_metre(string)
          when MILE_YARD_FOOT             then parse_mile_yard_foot(string)
          when FOOT_INCH_YARD             then parse_foot_inch_yard(string)
          when FOOT_INCH_CENTIMETRE       then parse_foot_inch_centimetre(string)
          when MILE_FURLONG_YARD          then parse_mile_furlong_yard(string)
          when CHAIN_FOOT_INCH            then parse_chain_foot_inch(string)
          when FOOT_INCH_MILLIMETRE       then parse_foot_inch_millimetre(string)
          when FATHOM_FOOT_INCH           then parse_fathom_foot_inch(string)
          when FURLONG_CHAIN_FOOT         then parse_furlong_chain_foot(string)
          when KILOMETRE_METRE_MILLIMETRE then parse_kilometre_metre_millimetre(string)
          else                                 raise Unitify::ParseError, string
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

        def parse_foot_inch_yard(string)
          foot, inch, yard = string.match(FOOT_INCH_YARD)&.captures

          if foot && inch && yard
            Unitify::Length.new(foot, :ft) +
              Unitify::Length.new(inch, :in) +
              Unitify::Length.new(yard, :yd)
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

        def parse_mile_furlong_yard(string)
          mile, furlong, yard = string.match(MILE_FURLONG_YARD)&.captures

          if mile && furlong && yard
            Unitify::Length.new(mile, :mi) +
              Unitify::Length.new(furlong, :fur) +
              Unitify::Length.new(yard, :yd)
          end
        end

        def parse_chain_foot_inch(string)
          chain, foot, inch = string.match(CHAIN_FOOT_INCH)&.captures

          if chain && foot && inch
            Unitify::Length.new(chain, :ch) +
              Unitify::Length.new(foot, :ft) +
              Unitify::Length.new(inch, :in)
          end
        end

        def parse_fathom_foot_inch(string)
          fathom, foot, inch = string.match(FATHOM_FOOT_INCH)&.captures

          if fathom && foot && inch
            Unitify::Length.new(fathom, :ftm) +
              Unitify::Length.new(foot, :ft) +
              Unitify::Length.new(inch, :in)
          end
        end

        def parse_furlong_chain_foot(string)
          furlong, chain, foot = string.match(FURLONG_CHAIN_FOOT)&.captures

          if furlong && chain && foot
            Unitify::Length.new(furlong, :fur) +
              Unitify::Length.new(chain, :ch) +
              Unitify::Length.new(foot, :ft)
          end
        end

        def parse_foot_inch_millimetre(string)
          foot, inch, millimetre = string.match(FOOT_INCH_MILLIMETRE)&.captures

          if foot && inch && millimetre
            Unitify::Length.new(foot, :ft) +
              Unitify::Length.new(inch, :in) +
              Unitify::Length.new(millimetre, :mm)
          end
        end

        def parse_kilometre_metre_millimetre(string)
          kilometre, metre, millimetre = string.match(KILOMETRE_METRE_MILLIMETRE)&.captures

          if kilometre && metre && millimetre
            Unitify::Length.new(kilometre, :km) +
              Unitify::Length.new(metre, :m) +
              Unitify::Length.new(millimetre, :mm)
          end
        end
      end

      private

      FOOT_UNITS       = /(?:'|ft|foot|feet)/.freeze
      INCH_UNITS       = /(?:"|in|inch(?:es)?)/.freeze
      METRE_UNITS      = /(?:m|meter(?:s)?|metre(?:s)?)/.freeze
      MILLIMETRE_UNITS = /(?:mm|millimeter(?:s)?|millimetre(?:s)?)/.freeze
      CENTIMETRE_UNITS = /(?:cm|centimeter(?:s)?|centimetre(?:s)?)/.freeze
      KILOMETRE_UNITS  = /(?:km|kilometer(?:s)?|kilometre(?:s)?)/.freeze
      MILE_UNITS       = /(?:mi|mile(?:s)?)/.freeze
      YARD_UNITS       = /(?:yd|yard(?:s)?)/.freeze
      FURLONG_UNITS    = /(?:fur|furlong(?:s)?)/.freeze
      CHAIN_UNITS      = /(?:ch|chain(?:s)?)/.freeze
      FATHOM_UNITS     = /(?:ftm|fathom(?:s)?)/.freeze

      FOOT_INCH                  = /\A#{NUMBER_WITH_T_SPACES}#{FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{INCH_UNITS}\z/.freeze
      METRE_CENTIMETRE           = /\A#{NUMBER_WITH_T_SPACES}#{METRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{CENTIMETRE_UNITS}\z/.freeze
      MILE_YARD                  = /\A#{NUMBER_WITH_T_SPACES}#{MILE_UNITS}#{NUMBER_WITH_LT_SPACES}#{YARD_UNITS}\z/.freeze
      KILOMETRE_METRE            = /\A#{NUMBER_WITH_T_SPACES}#{KILOMETRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{METRE_UNITS}\z/.freeze
      MILE_YARD_FOOT             = /\A#{NUMBER_WITH_T_SPACES}#{MILE_UNITS}#{NUMBER_WITH_LT_SPACES}#{YARD_UNITS}#{NUMBER_WITH_LT_SPACES}#{FOOT_UNITS}\z/.freeze
      FOOT_INCH_CENTIMETRE       = /\A#{NUMBER_WITH_T_SPACES}#{FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{INCH_UNITS}#{NUMBER_WITH_LT_SPACES}#{CENTIMETRE_UNITS}\z/.freeze
      FOOT_INCH_YARD             = /\A#{NUMBER_WITH_T_SPACES}#{FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{INCH_UNITS}#{NUMBER_WITH_LT_SPACES}#{YARD_UNITS}\z/.freeze
      MILE_FURLONG_YARD          = /\A#{NUMBER_WITH_T_SPACES}#{MILE_UNITS}#{NUMBER_WITH_LT_SPACES}#{FURLONG_UNITS}#{NUMBER_WITH_LT_SPACES}#{YARD_UNITS}\z/.freeze
      FOOT_INCH_MILLIMETRE       = /\A#{NUMBER_WITH_T_SPACES}#{FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{INCH_UNITS}#{NUMBER_WITH_LT_SPACES}#{MILLIMETRE_UNITS}\z/.freeze
      KILOMETRE_METRE_MILLIMETRE = /\A#{NUMBER_WITH_T_SPACES}#{KILOMETRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{METRE_UNITS}#{NUMBER_WITH_LT_SPACES}#{MILLIMETRE_UNITS}\z/.freeze
      CHAIN_FOOT_INCH            = /\A#{NUMBER_WITH_T_SPACES}#{CHAIN_UNITS}#{NUMBER_WITH_LT_SPACES}#{FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{INCH_UNITS}\z/.freeze
      FATHOM_FOOT_INCH           = /\A#{NUMBER_WITH_T_SPACES}#{FATHOM_UNITS}#{NUMBER_WITH_LT_SPACES}#{FOOT_UNITS}#{NUMBER_WITH_LT_SPACES}#{INCH_UNITS}\z/.freeze
      FURLONG_CHAIN_FOOT         = /\A#{NUMBER_WITH_T_SPACES}#{FURLONG_UNITS}#{NUMBER_WITH_LT_SPACES}#{CHAIN_UNITS}#{NUMBER_WITH_LT_SPACES}#{FOOT_UNITS}\z/.freeze
    end
  end
end
