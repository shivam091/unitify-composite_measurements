# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unitify/unit_groups/time"

module Unitify
  module CompositeMeasurements
    class Time
      class << self
        def parse(string)
          case string
          when HOUR_MINUTE     then parse_hour_minute(string)
          when MINUTE_SECOND   then parse_minute_second(string)
          when WEEK_DAY        then parse_week_day(string)
          when MONTH_DAY       then parse_month_day(string)
          when YEAR_MONTH      then parse_year_month(string)
          when QUARTER_MONTH   then parse_quarter_month(string)
          when FORTNIGHT_DAY   then parse_fortnight_day(string)
          when DURATION        then parse_duration(string)
          when DAY_HOUR_MINUTE then parse_day_hour_minute(string)
          else                      raise Unitify::ParseError, string
          end
        end

        private

        def parse_hour_minute(string)
          hour, minute = string.match(HOUR_MINUTE)&.captures

          if hour && minute
            Unitify::Time.new(hour, :h) + Unitify::Time.new(minute, :min)
          end
        end

        def parse_minute_second(string)
          minute, second = string.match(MINUTE_SECOND)&.captures

          if minute && second
            Unitify::Time.new(minute, :min) + Unitify::Time.new(second, :s)
          end
        end

        def parse_week_day(string)
          week, day = string.match(WEEK_DAY)&.captures

          if week && day
            Unitify::Time.new(week, :wk) + Unitify::Time.new(day, :d)
          end
        end

        def parse_month_day(string)
          month, day = string.match(MONTH_DAY)&.captures

          if month && day
            Unitify::Time.new(month, :mo) + Unitify::Time.new(day, :d)
          end
        end

        def parse_year_month(string)
          year, month = string.match(YEAR_MONTH)&.captures

          if year && month
            Unitify::Time.new(year, :yr) + Unitify::Time.new(month, :mo)
          end
        end

        def parse_quarter_month(string)
          quarter, month = string.match(QUARTER_MONTH)&.captures

          if quarter && month
            Unitify::Time.new(quarter, :qtr) + Unitify::Time.new(month, :mo)
          end
        end

        def parse_fortnight_day(string)
          fortnight, day = string.match(FORTNIGHT_DAY)&.captures

          if fortnight && day
            Unitify::Time.new(fortnight, :fn) + Unitify::Time.new(day, :d)
          end
        end

        def parse_duration(string)
          hour, minute, second, microsecond = string.match(DURATION)&.captures
          raise ArgumentError, "Invalid Duration" if [hour, minute, second, microsecond].all?(&:nil?)

          Unitify::Time.new((hour || 0), :h) +
            Unitify::Time.new((minute || 0), :min) +
            Unitify::Time.new((second || 0), :s) +
            Unitify::Time.new((microsecond || 0), :μs)
        end

        def parse_day_hour_minute(string)
          day, hour, minute = string.match(DAY_HOUR_MINUTE)&.captures

          if day && hour && minute
            Unitify::Time.new(day, :d) +
              Unitify::Time.new(hour, :h) +
              Unitify::Time.new(minute, :min)
          end
        end
      end

      private

      HOUR_UNITS      = /(?:h|hr|hour(?:s)?)/.freeze
      MINUTE_UNITS    = /(?:min|minute(?:s)?)/.freeze
      SECOND_UNITS    = /(?:s|sec|second(?:s)?)/.freeze
      DAY_UNITS       = /(?:d|day(?:s)?)/.freeze
      WEEK_UNITS      = /(?:wk|week(?:s)?)/.freeze
      MONTH_UNITS     = /(?:mo|month(?:s)?)/.freeze
      QUARTER_UNITS   = /(?:qtr|quarter(?:s)?)/.freeze
      YEAR_UNITS      = /(?:y|yr|year(?:s)?)/.freeze
      FORTNIGHT_UNITS = /(?:fn|4tnite|fortnight(?:s)?)/.freeze

      HOUR_MINUTE     = /\A#{NUMBER_WITH_T_SPACES}#{HOUR_UNITS}#{NUMBER_WITH_LT_SPACES}#{MINUTE_UNITS}\z/.freeze
      MINUTE_SECOND   = /\A#{NUMBER_WITH_T_SPACES}#{MINUTE_UNITS}#{NUMBER_WITH_LT_SPACES}#{SECOND_UNITS}\z/.freeze
      WEEK_DAY        = /\A#{NUMBER_WITH_T_SPACES}#{WEEK_UNITS}#{NUMBER_WITH_LT_SPACES}#{DAY_UNITS}\z/.freeze
      MONTH_DAY       = /\A#{NUMBER_WITH_T_SPACES}#{MONTH_UNITS}#{NUMBER_WITH_LT_SPACES}#{DAY_UNITS}\z/.freeze
      YEAR_MONTH      = /\A#{NUMBER_WITH_T_SPACES}#{YEAR_UNITS}#{NUMBER_WITH_LT_SPACES}#{MONTH_UNITS}\z/.freeze
      QUARTER_MONTH   = /\A#{NUMBER_WITH_T_SPACES}#{QUARTER_UNITS}#{NUMBER_WITH_LT_SPACES}#{MONTH_UNITS}\z/.freeze
      FORTNIGHT_DAY   = /\A#{NUMBER_WITH_T_SPACES}#{FORTNIGHT_UNITS}#{NUMBER_WITH_LT_SPACES}#{DAY_UNITS}\z/.freeze
      DURATION        = /\A(?<hour>#{ANY_REAL_NUMBER}):(?<min>#{ANY_REAL_NUMBER}):(?:(?<sec>#{ANY_REAL_NUMBER}))?(?:,(?<msec>#{ANY_REAL_NUMBER}))?\z/.freeze
      DAY_HOUR_MINUTE = /\A#{NUMBER_WITH_T_SPACES}#{DAY_UNITS}#{NUMBER_WITH_LT_SPACES}#{HOUR_UNITS}#{NUMBER_WITH_LT_SPACES}#{MINUTE_UNITS}\z/.freeze
    end
  end
end
