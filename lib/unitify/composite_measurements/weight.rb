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
          when POUND_OUNCE       then parse_pound_ounce(string)
          when STONE_POUND       then parse_stone_pound(string)
          when KILOGRAMME_GRAMME then parse_kilogramme_gramme(string)
          when TONNE_KILOGRAMME  then parse_tonne_kilogramme(string)
          when STONE_POUND_OUNCE then parse_stone_pound_ounce(string)
          else                        raise Unitify::ParseError, string
          end
        end

        private

        def parse_pound_ounce(string)
          pound, ounce = string.match(POUND_OUNCE)&.captures

          if pound && ounce
            Unitify::Weight.new(pound, :lb) + Unitify::Weight.new(ounce, :oz)
          end
        end

        def parse_stone_pound(string)
          stone, pound = string.match(STONE_POUND)&.captures

          if stone && pound
            Unitify::Weight.new(stone, :st) + Unitify::Weight.new(pound, :lb)
          end
        end

        def parse_kilogramme_gramme(string)
          kilogramme, gramme = string.match(KILOGRAMME_GRAMME)&.captures

          if kilogramme && gramme
            Unitify::Weight.new(kilogramme, :kg) + Unitify::Weight.new(gramme, :g)
          end
        end

        def parse_tonne_kilogramme(string)
          tonne, kilogramme = string.match(TONNE_KILOGRAMME)&.captures

          if tonne && kilogramme
            Unitify::Weight.new(tonne, :t) + Unitify::Weight.new(kilogramme, :kg)
          end
        end

        def parse_stone_pound_ounce(string)
          stone, pound, ounce = string.match(STONE_POUND_OUNCE)&.captures

          if stone && pound && ounce
            Unitify::Weight.new(stone, :st) +
              Unitify::Weight.new(pound, :lb) +
              Unitify::Weight.new(ounce, :oz)
          end
        end
      end

      private

      POUND_UNITS      = /(?:#|lb|lbs|lbm|pound-mass|pound(?:s)?)/.freeze
      OUNCE_UNITS      = /(?:oz|ounce(?:s)?)/.freeze
      STONE_UNITS      = /(?:st|stone(?:s)?)/.freeze
      GRAMME_UNITS     = /(?:g|gram(?:s)?|gramme(?:s)?)/.freeze
      KILOGRAMME_UNITS = /(?:kg|kilogram(?:s)?|kilogramme(?:s)?)/.freeze
      TONNE_UNITS      = /(?:t|tonne(?:s)?|metric tonne(?:s)?)/.freeze

      POUND_OUNCE       = /\A#{NUMBER_WITH_T_SPACES}#{POUND_UNITS}#{NUMBER_WITH_LT_SPACES}#{OUNCE_UNITS}\z/.freeze
      STONE_POUND       = /\A#{NUMBER_WITH_T_SPACES}#{STONE_UNITS}#{NUMBER_WITH_LT_SPACES}#{POUND_UNITS}\z/.freeze
      KILOGRAMME_GRAMME = /\A#{NUMBER_WITH_T_SPACES}#{KILOGRAMME_UNITS}#{NUMBER_WITH_LT_SPACES}#{GRAMME_UNITS}\z/.freeze
      TONNE_KILOGRAMME  = /\A#{NUMBER_WITH_T_SPACES}#{TONNE_UNITS}#{NUMBER_WITH_LT_SPACES}#{KILOGRAMME_UNITS}\z/.freeze
      STONE_POUND_OUNCE = /\A#{NUMBER_WITH_T_SPACES}#{STONE_UNITS}#{NUMBER_WITH_LT_SPACES}#{POUND_UNITS}#{NUMBER_WITH_LT_SPACES}#{OUNCE_UNITS}\z/.freeze
    end
  end
end
