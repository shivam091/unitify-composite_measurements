# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unitify/unit_groups/weight"

module Unitify
  module CompositeMeasurements
    class Weight
      class << self
        def parse(string)
          case string
          when POUNDS_OUNCES_REGEX        then parse_pounds_ounces(string)
          when STONES_POUNDS_REGEX        then parse_stones_pounds(string)
          when STONES_POUNDS_OUNCES_REGEX then parse_stones_pounds_ounces(string)
          when KILOGRAMMES_GRAMMES_REGEX  then parse_kilogrammes_grammes(string)
          when TONNES_KILOGRAMMES_REGEX   then parse_tonnes_kilogrammes(string)
          else                                 raise Unitify::ParseError, string
          end
        end

        private

        def parse_pounds_ounces(string)
          pounds, ounces = string.match(POUNDS_OUNCES_REGEX)&.captures

          if pounds && ounces
            Unitify::Weight.new(pounds, :lb) + Unitify::Weight.new(ounces, :oz)
          end
        end

        def parse_stones_pounds(string)
          stones, pounds = string.match(STONES_POUNDS_REGEX)&.captures

          if stones && pounds
            Unitify::Weight.new(stones, :st) + Unitify::Weight.new(pounds, :lb)
          end
        end

        def parse_kilogrammes_grammes(string)
          kilogrammes, grammes = string.match(KILOGRAMMES_GRAMMES_REGEX)&.captures

          if kilogrammes && grammes
            Unitify::Weight.new(kilogrammes, :kg) + Unitify::Weight.new(grammes, :g)
          end
        end

        def parse_tonnes_kilogrammes(string)
          tonnes, kilogrammes = string.match(TONNES_KILOGRAMMES_REGEX)&.captures

          if tonnes && kilogrammes
            Unitify::Weight.new(tonnes, :t) + Unitify::Weight.new(kilogrammes, :kg)
          end
        end

        def parse_stones_pounds_ounces(string)
          stones, pounds, ounces = string.match(STONES_POUNDS_OUNCES_REGEX)&.captures

          if stones && pounds && ounces
            Unitify::Weight.new(stones, :st) +
              Unitify::Weight.new(pounds, :lb) +
              Unitify::Weight.new(ounces, :oz)
          end
        end
      end

      private

      POUNDS_UNIT_REGEX      = /(?:#|lb|lbs|lbm|pound-mass|pound(?:s)?)/.freeze
      OUNCES_UNIT_REGEX      = /(?:oz|ounce(?:s)?)/.freeze
      STONES_UNIT_REGEX      = /(?:st|stone(?:s)?)/.freeze
      GRAMMES_UNIT_REGEX     = /(?:g|gram(?:s)?|gramme(?:s)?)/.freeze
      KILOGRAMMES_UNIT_REGEX = /(?:kg|kilogram(?:s)?|kilogramme(?:s)?)/.freeze
      TONNES_UNIT_REGEX      = /(?:t|tonne(?:s)?|metric tonne(?:s)?)/.freeze

      POUNDS_OUNCES_REGEX        = /\A#{NUMBER_WITH_T_SPACES}#{POUNDS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{OUNCES_UNIT_REGEX}\z/.freeze
      STONES_POUNDS_REGEX        = /\A#{NUMBER_WITH_T_SPACES}#{STONES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{POUNDS_UNIT_REGEX}\z/.freeze
      KILOGRAMMES_GRAMMES_REGEX  = /\A#{NUMBER_WITH_T_SPACES}#{KILOGRAMMES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{GRAMMES_UNIT_REGEX}\z/.freeze
      STONES_POUNDS_OUNCES_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{STONES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{POUNDS_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{OUNCES_UNIT_REGEX}\z/.freeze
      TONNES_KILOGRAMMES_REGEX   = /\A#{NUMBER_WITH_T_SPACES}#{TONNES_UNIT_REGEX}#{NUMBER_WITH_LT_SPACES}#{KILOGRAMMES_UNIT_REGEX}\z/.freeze
    end
  end
end
