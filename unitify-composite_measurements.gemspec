# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "unitify/composite_measurements/version"

Gem::Specification.new do |spec|
  spec.name = "unitify-composite_measurements"
  spec.version = Unitify::CompositeMeasurements::VERSION
  spec.authors = ["Harshal LADHE"]
  spec.email = ["harshal.ladhe.1@gmail.com"]

  spec.summary = "A set of specialized parsers for dealing with composite measurement strings."
  spec.description = "A set of specialized parsers for processing composite measurement strings."
  spec.homepage = "https://github.com/shivam091/unitify-composite_measurements"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/shivam091/unitify-composite_measurements"
  spec.metadata["changelog_uri"] = "https://github.com/shivam091/unitify-composite_measurements/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/shivam091/unitify-composite_measurements/issues"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", "~> 7.0"
  spec.add_runtime_dependency "unitify", "~> 3"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.21", ">= 0.21.2"
  spec.add_development_dependency "byebug", "~> 11"
end
