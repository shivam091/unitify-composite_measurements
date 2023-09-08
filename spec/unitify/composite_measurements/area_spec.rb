# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/unitify/composite_measurements/area_spec.rb

RSpec.describe Unitify::CompositeMeasurements::Area do
  subject { described_class }

  describe "#parse" do
    context "when valid string is passed" do
      it "parses acre and square metre" do
        expect(subject.parse("2 ac 200 m²").to_s).to eq("2.049421076293433 ac")
        expect(subject.parse("2 acre 200 m2").to_s).to eq("2.049421076293433 ac")
        expect(subject.parse("2 acres 200 m^2").to_s).to eq("2.049421076293433 ac")
        expect(subject.parse("2 acres 200 m*m").to_s).to eq("2.049421076293433 ac")
        expect(subject.parse("2 acres 200 square meter").to_s).to eq("2.049421076293433 ac")
        expect(subject.parse("2 acres 200 square meters").to_s).to eq("2.049421076293433 ac")
        expect(subject.parse("2 acres 200 square metre").to_s).to eq("2.049421076293433 ac")
        expect(subject.parse("2 acres 200 square metres").to_s).to eq("2.049421076293433 ac")
      end

      it "parses square foot and square inch" do
        expect(subject.parse("7 ft² 48 in²").to_s).to eq("7.333333333333333 ft²")
        expect(subject.parse("7 ft2 48 in2").to_s).to eq("7.333333333333333 ft²")
        expect(subject.parse("7 ft^2 48 in^2").to_s).to eq("7.333333333333333 ft²")
        expect(subject.parse("7 ft*ft 48 in*in").to_s).to eq("7.333333333333333 ft²")
        expect(subject.parse("7 square foot 48 square inch").to_s).to eq("7.333333333333333 ft²")
        expect(subject.parse("7 square feet 48 square inches").to_s).to eq("7.333333333333333 ft²")
      end

      it "parses square foot and square metre" do
        expect(subject.parse("500 ft² 2 m²").to_s).to eq("521.5278208334194 ft²")
        expect(subject.parse("500 ft2 2 m2").to_s).to eq("521.5278208334194 ft²")
        expect(subject.parse("500 ft^2 2 m^2").to_s).to eq("521.5278208334194 ft²")
        expect(subject.parse("500 ft*ft 2 m*m").to_s).to eq("521.5278208334194 ft²")
        expect(subject.parse("500 square foot 2 square meter").to_s).to eq("521.5278208334194 ft²")
        expect(subject.parse("500 square feet 2 square meters").to_s).to eq("521.5278208334194 ft²")
        expect(subject.parse("500 square foot 2 square metre").to_s).to eq("521.5278208334194 ft²")
        expect(subject.parse("500 square feet 2 square metres").to_s).to eq("521.5278208334194 ft²")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { subject.parse("2 acs 200 m²") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 acress 200 sq ms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 acress 200 sq meterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 acrez 200 sq meterz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("7 fts² 48 ins²") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("7 sq fts 48 sq ins") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("7 sq foots 48 sq inchess") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("7 sq footz 48 sq inchez") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("500 fts² 2 ms²") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("500 sq fts 2 sq ms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("500 sq foots 2 sq meterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("500 sq footz 2 sq metress") }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
