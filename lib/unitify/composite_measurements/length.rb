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
          when FT_IN_REGEX then parse_ft_in(string)
          else                  raise Unitify::ParseError, string
          end
        end

        private

        def parse_ft_in(string)
          feet, inches = string.match(FT_IN_REGEX)&.captures

          if feet && inches
            Unitify::Length.new(feet, :ft) + Unitify::Length.new(inches, :in)
          end
        end
      end

      private

      FT_REGEX    = /(?:'|ft|foot|feet)/.freeze
      IN_REGEX    = /(?:"|in|inch(?:es)?)/.freeze

      FT_IN_REGEX = /\A#{ANY_DIGIT_WITH_T_SPACES}#{FT_REGEX}#{ANY_DIGIT_WITH_LT_SPACES}#{IN_REGEX}\z/.freeze
    end
  end
end
