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
      end

      private

      DURATION_REGEX = /\A(?<hour>#{ANY_DIGIT}):(?<min>#{ANY_DIGIT}):(?:(?<sec>#{ANY_DIGIT}))?(?:,(?<msec>#{ANY_DIGIT}))?\z/.freeze
    end
  end
end
