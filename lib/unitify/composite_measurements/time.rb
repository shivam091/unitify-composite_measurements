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
      end

      private

      HOURS_UNIT_REGEX        = /(?:h|hr|hour(?:s)?)/.freeze
      MINUTES_UNIT_REGEX      = /(?:min|minute(?:s)?)/.freeze
      DAYS_UNIT_REGEX        = /(?:d|day(?:s)?)/.freeze

      DURATION_REGEX           = /\A(?<hour>#{ANY_NUMBER}):(?<min>#{ANY_NUMBER}):(?:(?<sec>#{ANY_NUMBER}))?(?:,(?<msec>#{ANY_NUMBER}))?\z/.freeze
      HOURS_MINUTES_REGEX      = /\A#{NUMBER_WITH_T_SPACES}#{HOURS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{MINUTES_UNIT_REGEX}\z/.freeze
      DAYS_HOURS_MINUTES_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{DAYS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{HOURS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{MINUTES_UNIT_REGEX}\z/.freeze
    end
  end
end
