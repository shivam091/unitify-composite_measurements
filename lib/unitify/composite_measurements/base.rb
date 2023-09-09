# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

require "unitify/base"
require "unitify/composite_measurements/version"

module Unitify
  module CompositeMeasurements
    # Matches real numbers in the form of 31, +72, or -12.
    ANY_REAL_NUMBER         = /
      (?:                     # Start of non-capturing group
        [+-]?                 # Optional plus (+) or minus (-) sign
        \d+                   # One or more digits
      )                       # End of non-capturing group
    /x.freeze

    # Matches a rational number in the form of a/b (fractional) or a b/c (mixed fractional).
    RATIONAL_NUMBER_REGEX   = /
      (?:                     # Start of optional non-capturing group
        [+-]?                 # Optional plus (+) or minus (-) sign
        \d+                   # One or more digits
        \s+                   # One or more whitespace
      )?                      # End of optional non-capturing group
      (                       # Start of capturing group for the fraction
        (\d+)                 # Capture the numerator (one or more digits)
        \/                    # Match the forward slash, indicating division
        (\d+)                 # Capture the denominator (one or more digits)
      )                       # End of capturing group for the fraction
    /x.freeze

    # Matches a scientific number in various formats like 1.23E+4 or -5.67e-8.
    SCIENTIFIC_NUMBER_REGEX = /
      (?:                     # Start of non-capturing group
        [+-]?                 # Optional plus (+) or minus (-) sign
        \d*                   # Zero or more digits (integer part)
        \.?                   # Optional decimal point
        \d+                   # One or more digits (fractional part)
        (?:                   # Start of non-capturing group for exponent part
          [Ee]                # Match 'E' or 'e' for exponentiation
          [+-]?               # Optional plus (+) or minus (-) sign for exponent
          \d+                 # One or more digits (exponent value)
        )?                    # End of non-capturing group of exponent part (optional)
      )                       # End of non-capturing group
    /x.freeze

    # Matches complex numbers in the form of a+bi, where both 'a' and 'b' can be
    # in scientific notation. It captures the real and imaginary parts.
    COMPLEX_NUMBER_REGEX    = /#{SCIENTIFIC_NUMBER_REGEX}#{SCIENTIFIC_NUMBER_REGEX}i/.freeze

    # Matches any number, including scientific, complex, rational, and real numbers.
    ANY_NUMBER_REGEX        = /(?<number>#{SCIENTIFIC_NUMBER_REGEX}|#{COMPLEX_NUMBER_REGEX}|#{RATIONAL_NUMBER_REGEX}|#{ANY_REAL_NUMBER})/.freeze

    # Matches zero or more whitespace characters.
    SPACES                  = /\s*/.freeze

    # Matches a number followed by optional spaces.
    NUMBER_WITH_T_SPACES    = /#{ANY_NUMBER_REGEX}#{SPACES}/.freeze

    # Matches a number surrounded by optional spaces.
    NUMBER_WITH_LT_SPACES   = /#{SPACES}#{ANY_NUMBER_REGEX}#{SPACES}/.freeze
  end
end
