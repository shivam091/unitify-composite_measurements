# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/unitify/composite_measurements/time_spec.rb

RSpec.describe Unitify::CompositeMeasurements::Time do
  subject { described_class }

  describe "#parse" do
    context "when valid string is passed" do
      it "parses duration" do
        expect(subject.parse("12:60:60,60").to_s).to eq("13.016666683333334 h")
        expect(subject.parse("12:60:60").to_s).to eq("13.016666666666667 h")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { subject.parse("10:20") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("10:20,20:30").to_s }.to raise_error(Unitify::ParseError)
        expect { subject.parse("10:20,20,30").to_s }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
