# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/unitify/composite_measurements/base_spec.rb

RSpec.describe Unitify::CompositeMeasurements do
  subject { Unitify::CompositeMeasurements::Length }

  it "parses real numbers" do
    expect(subject.parse("2 ft 12 in").to_s).to eq("3 ft")
    expect(subject.parse("-2 ft -12 in").to_s).to eq("-3 ft")
  end

  it "parses rational numbers" do
    expect(subject.parse("0.5 ft 0.5 in").to_s).to eq("0.5416666666666667 ft")
    expect(subject.parse("1/2 ft 1/2 in").to_s).to eq("0.5416666666666667 ft")
    expect(subject.parse("1 1/2 ft 1 1/2 in").to_s).to eq("1.625 ft")
    expect(subject.parse("-1 1/2 ft -1 1/2 in").to_s).to eq("-0.5416666666666667 ft")
  end

  it "parses scientific numbers" do
    expect(subject.parse("1e+1 ft 1e+1 in").to_s).to eq("10.833333333333332 ft")
    expect(subject.parse("1e-1 ft 1e-1 in").to_s).to eq("0.10833333333333332 ft")
    expect(subject.parse("-1e+1 ft -1e+1 in").to_s).to eq("-10.833333333333332 ft")
    expect(subject.parse("-1e-1 ft -1e-1 in").to_s).to eq("-0.10833333333333332 ft")
    expect(subject.parse("1e1 ft 1e1 in").to_s).to eq("10.833333333333332 ft")
    expect(subject.parse("-1e1 ft -1e1 in").to_s).to eq("-10.833333333333332 ft")
  end

  it "parses complex numbers" do
    expect(subject.parse("1+1i ft 1+1i in").to_s).to eq("1.0833333333333333+1.0833333333333333i ft")
    expect(subject.parse("1-1i ft 1-1i in").to_s).to eq("1.0833333333333333-1.0833333333333333i ft")
    expect(subject.parse("+1-1i ft +1-1i in").to_s).to eq("1.0833333333333333-1.0833333333333333i ft")
    expect(subject.parse("-1-1i ft -1-1i in").to_s).to eq("-1.0833333333333333-1.0833333333333333i ft")
    expect(subject.parse("1e+2+1i ft 1+1e+2i in").to_s).to eq("100.08333333333333+9.333333333333334i ft")
  end
end
