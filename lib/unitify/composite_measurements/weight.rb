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
          when LB_OZ_REGEX then parse_lb_oz(string)
          when ST_LB_REGEX then parse_st_lb(string)
          when KG_G_REGEX  then parse_kg_g(string)
          else                  raise Unitify::ParseError, string
          end
        end

        private

        def parse_lb_oz(string)
          pounds, ounces = string.match(LB_OZ_REGEX)&.captures

          if pounds && ounces
            Unitify::Weight.new(pounds, :lb) + Unitify::Weight.new(ounces, :oz)
          end
        end

        def parse_st_lb(string)
          stones, pounds = string.match(ST_LB_REGEX)&.captures

          if stones && pounds
            Unitify::Weight.new(stones, :st) + Unitify::Weight.new(pounds, :lb)
          end
        end

        def parse_kg_g(string)
          kilogrammes, grammes = string.match(KG_G_REGEX)&.captures

          if kilogrammes && grammes
            Unitify::Weight.new(kilogrammes, :kg) + Unitify::Weight.new(grammes, :g)
          end
        end
      end

      private

      LB_REGEX    = /(?:#|lb|lbs|lbm|pound-mass|pound(?:s)?)/.freeze
      OZ_REGEX    = /(?:oz|ounce(?:s)?)/.freeze
      ST_REGEX    = /(?:st|stone(?:s)?)/.freeze
      G_REGEX     = /(?:g|gram(?:s)?|gramme(?:s)?)/.freeze
      KG_REGEX    = /(?:kg|kilogram(?:s)?|kilogramme(?:s)?)/.freeze

      LB_OZ_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{LB_REGEX}#{NUMBER_WITH_LT_SPACES}#{OZ_REGEX}\z/.freeze
      ST_LB_REGEX = /\A#{NUMBER_WITH_T_SPACES}#{ST_REGEX}#{NUMBER_WITH_LT_SPACES}#{LB_REGEX}\z/.freeze
      KG_G_REGEX  = /\A#{NUMBER_WITH_T_SPACES}#{KG_REGEX}#{NUMBER_WITH_LT_SPACES}#{G_REGEX}\z/.freeze
    end
  end
end
