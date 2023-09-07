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
          when DAYS_HOURS_MINUTES_REGEX  then parse_days_hours_minutes(string)
          when HOURS_MINUTES_REGEX       then parse_hours_minutes(string)
          when MINUTES_SECONDS_REGEX     then parse_minutes_seconds(string)
          when WEEKS_DAYS_REGEX          then parse_weeks_days(string)
          when MONTHS_DAYS_REGEX         then parse_months_days(string)
          when YEARS_MONTHS_REGEX        then parse_years_months(string)
          when QUARTERS_MONTHS_REGEX     then parse_quarters_months(string)
          when FORTNIGHTS_DAYS_REGEX     then parse_fortnights_days(string)
          when DURATION_REGEX            then parse_duration(string)
          else                                raise Unitify::ParseError, string
          end
        end

        private

        def parse_duration(string)
          hours, minutes, seconds, microseconds = string.match(DURATION_REGEX)&.captures
          raise ArgumentError, "Invalid Duration" if [hours, minutes, seconds, microseconds].all?(&:nil?)

          Unitify::Time.new((hours || 0), :h) +
            Unitify::Time.new((minutes || 0), :min) +
            Unitify::Time.new((seconds || 0), :s) +
            Unitify::Time.new((microseconds || 0), :μs)
        end

        def parse_days_hours_minutes(string)
          days, hours, minutes = string.match(DAYS_HOURS_MINUTES_REGEX)&.captures

          if days && hours && minutes
            Unitify::Time.new(days, :d) +
              Unitify::Time.new(hours, :h) +
              Unitify::Time.new(minutes, :min)
          end
        end

        def parse_hours_minutes(string)
          hours, minutes = string.match(HOURS_MINUTES_REGEX)&.captures

          if hours && minutes
            Unitify::Time.new(hours, :h) + Unitify::Time.new(minutes, :min)
          end
        end

        def parse_minutes_seconds(string)
          minutes, seconds = string.match(MINUTES_SECONDS_REGEX)&.captures

          if minutes && seconds
            Unitify::Time.new(minutes, :min) + Unitify::Time.new(seconds, :s)
          end
        end

        def parse_weeks_days(string)
          weeks, days = string.match(WEEKS_DAYS_REGEX)&.captures

          if weeks && days
            Unitify::Time.new(weeks, :wk) + Unitify::Time.new(days, :d)
          end
        end

        def parse_months_days(string)
          months, days = string.match(MONTHS_DAYS_REGEX)&.captures

          if months && days
            Unitify::Time.new(months, :mo) + Unitify::Time.new(days, :d)
          end
        end

        def parse_years_months(string)
          years, months = string.match(YEARS_MONTHS_REGEX)&.captures

          if years && months
            Unitify::Time.new(years, :yr) + Unitify::Time.new(months, :mo)
          end
        end

        def parse_quarters_months(string)
          quarters, months = string.match(QUARTERS_MONTHS_REGEX)&.captures

          if quarters && months
            Unitify::Time.new(quarters, :qtr) + Unitify::Time.new(months, :mo)
          end
        end

        def parse_fortnights_days(string)
          fortnights, days = string.match(FORTNIGHTS_DAYS_REGEX)&.captures

          if fortnights && days
            Unitify::Time.new(fortnights, :fn) + Unitify::Time.new(days, :d)
          end
        end
      end

      private

      HOURS_UNIT_REGEX      = /(?:h|hr|hour(?:s)?)/.freeze
      MINUTES_UNIT_REGEX    = /(?:min|minute(?:s)?)/.freeze
      SECONDS_UNIT_REGEX    = /(?:s|sec|second(?:s)?)/.freeze
      DAYS_UNIT_REGEX       = /(?:d|day(?:s)?)/.freeze
      WEEKS_UNIT_REGEX      = /(?:wk|week(?:s)?)/.freeze
      MONTHS_UNIT_REGEX     = /(?:mo|month(?:s)?)/.freeze
      QUARTERS_UNIT_REGEX   = /(?:qtr|quarter(?:s)?)/.freeze
      YEARS_UNIT_REGEX      = /(?:y|yr|year(?:s)?)/.freeze
      FORTNIGHTS_UNIT_REGEX = /(?:fn|4tnite|fortnight(?:s)?)/.freeze

      DURATION_REGEX           = /\A(?<hour>#{ANY_NUMBER}):(?<min>#{ANY_NUMBER}):(?:(?<sec>#{ANY_NUMBER}))?(?:,(?<msec>#{ANY_NUMBER}))?\z/.freeze
      HOURS_MINUTES_REGEX      = /\A#{NUMBER_WITH_T_SPACES}#{HOURS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{MINUTES_UNIT_REGEX}\z/.freeze
      DAYS_HOURS_MINUTES_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{DAYS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{HOURS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{MINUTES_UNIT_REGEX}\z/.freeze
      MINUTES_SECONDS_REGEX    = /\A#{NUMBER_WITH_T_SPACES}#{MINUTES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{SECONDS_UNIT_REGEX}\z/.freeze
      WEEKS_DAYS_REGEX         = /\A#{NUMBER_WITH_T_SPACES}#{WEEKS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{DAYS_UNIT_REGEX}\z/.freeze
      MONTHS_DAYS_REGEX        = /\A#{NUMBER_WITH_T_SPACES}#{MONTHS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{DAYS_UNIT_REGEX}\z/.freeze
      YEARS_MONTHS_REGEX       = /\A#{NUMBER_WITH_T_SPACES}#{YEARS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{MONTHS_UNIT_REGEX}\z/.freeze
      QUARTERS_MONTHS_REGEX    = /\A#{NUMBER_WITH_T_SPACES}#{QUARTERS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{MONTHS_UNIT_REGEX}\z/.freeze
      FORTNIGHTS_DAYS_REGEX    = /\A#{NUMBER_WITH_T_SPACES}#{FORTNIGHTS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{DAYS_UNIT_REGEX}\z/.freeze
    end
  end
end
