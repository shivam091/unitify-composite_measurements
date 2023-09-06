# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unitify/base"
require "unitify/composite_measurements/version"

module Unitify
  module CompositeMeasurements
    private

    ANY_DIGIT                = /(\d+)/.freeze
    SPACES                   = /\s*/.freeze
    NUMBER_WITH_T_SPACES  = /#{ANY_DIGIT}#{SPACES}/.freeze
    NUMBER_WITH_LT_SPACES = /#{SPACES}#{ANY_DIGIT}#{SPACES}/.freeze
  end
end
