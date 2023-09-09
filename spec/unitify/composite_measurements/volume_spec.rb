# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/unitify/composite_measurements/volume_spec.rb

RSpec.describe Unitify::CompositeMeasurements::Volume do
  subject { described_class }

  describe "#parse" do
    context "when valid string is passed" do
      it "parses litre and millilitre" do
        expect(subject.parse("2 l 250 ml").to_s).to eq("2.25 l")
        expect(subject.parse("2 L 250 mL").to_s).to eq("2.25 l")
        expect(subject.parse("2 liter 250 milliliter").to_s).to eq("2.25 l")
        expect(subject.parse("2 liters 250 milliliters").to_s).to eq("2.25 l")
        expect(subject.parse("2 litre 250 millilitre").to_s).to eq("2.25 l")
        expect(subject.parse("2 litres 250 millilitres").to_s).to eq("2.25 l")
      end

      it "parses cubic metre and cubic centimetre" do
        expect(subject.parse("0.5 m³ 1000 cm³").to_s).to eq("0.501 m³")
        expect(subject.parse("0.5 m3 1000 cm3").to_s).to eq("0.501 m³")
        expect(subject.parse("0.5 m^3 1000 cm^3").to_s).to eq("0.501 m³")
        expect(subject.parse("0.5 m*m*m 1000 cm*cm*cm").to_s).to eq("0.501 m³")
        expect(subject.parse("0.5 cubic meter 1000 cubic centimeter").to_s).to eq("0.501 m³")
        expect(subject.parse("0.5 cubic meters 1000 cubic centimeters").to_s).to eq("0.501 m³")
        expect(subject.parse("0.5 cubic metre 1000 cubic centimetre").to_s).to eq("0.501 m³")
        expect(subject.parse("0.5 cubic metres 1000 cubic centimetres").to_s).to eq("0.501 m³")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { subject.parse("2 literss 250 milliliterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 literss 250 milliliterr") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 litress 250 millilitress").to_s }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 ls 250 mls").to_s }.to raise_error(Unitify::ParseError)

        expect { subject.parse("0.5 ms³ 1000 cms³") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("0.5 cubic meterss 1000 cubic centimeterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("0.5 cubic meterz 1000 cubic centimeterz").to_s }.to raise_error(Unitify::ParseError)
        expect { subject.parse("0.5 cubic metress 1000 cubic centimetress").to_s }.to raise_error(Unitify::ParseError)
        expect { subject.parse("0.5 cubic metrez 1000 cubic centimetrez").to_s }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
