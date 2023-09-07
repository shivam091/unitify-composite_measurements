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
          when D_H_MIN_REGEX  then parse_days_hours_minutes(string)
          when H_MIN_REGEX    then parse_hours_minutes(string)
          when DURATION_REGEX then parse_duration(string)
          else                     raise Unitify::ParseError, string
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
          days, hours, minutes = string.match(D_H_MIN_REGEX)&.captures

          if days && hours && minutes
            Unitify::Time.new(days, :d) +
              Unitify::Time.new(hours, :h) +
              Unitify::Time.new(minutes, :min)
          end
        end

        def parse_hours_minutes(string)
          hours, minutes = string.match(H_MIN_REGEX)&.captures

          if hours && minutes
            Unitify::Time.new(hours, :h) + Unitify::Time.new(minutes, :min)
          end
        end
      end

      private

      H_REGEX        = /(?:h|hr|hour(?:s)?)/.freeze
      MIN_REGEX      = /(?:min|minute(?:s)?)/.freeze
      D_REGEX        = /(?:d|day(?:s)?)/.freeze

      DURATION_REGEX = /\A(?<hour>#{ANY_DIGIT}):(?<min>#{ANY_DIGIT}):(?:(?<sec>#{ANY_DIGIT}))?(?:,(?<msec>#{ANY_DIGIT}))?\z/.freeze
      H_MIN_REGEX    = /\A#{NUMBER_WITH_T_SPACES}#{H_REGEX}#{NUMBER_WITH_LT_SPACES}#{MIN_REGEX}\z/.freeze
      D_H_MIN_REGEX  = /\A#{NUMBER_WITH_T_SPACES}#{D_REGEX}#{NUMBER_WITH_LT_SPACES}#{H_REGEX}#{NUMBER_WITH_LT_SPACES}#{MIN_REGEX}\z/.freeze
    end
  end
end
