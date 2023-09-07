# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/unitify/composite_measurements/length_spec.rb

RSpec.describe Unitify::CompositeMeasurements::Length do
  subject { described_class }

  describe "#parse" do
    context "when valid string is passed" do
      it "parses feet and inches" do
        expect(subject.parse("5 \' 6 \"").to_s).to eq("5.5 ft")
        expect(subject.parse("5 ft 6 in").to_s).to eq("5.5 ft")
        expect(subject.parse("5 foot 6 inch").to_s).to eq("5.5 ft")
        expect(subject.parse("5 feet 6 inches").to_s).to eq("5.5 ft")
      end

      it "parses metres and centimetres" do
        expect(subject.parse("6 m 50 cm").to_s).to eq("6.5 m")
        expect(subject.parse("6 meter 50 centimeter").to_s).to eq("6.5 m")
        expect(subject.parse("6 metre 50 centimetre").to_s).to eq("6.5 m")
        expect(subject.parse("6 meters 50 centimeters").to_s).to eq("6.5 m")
        expect(subject.parse("6 metres 50 centimetres").to_s).to eq("6.5 m")
      end

      it "parses feet, inches, and centimetres" do
        expect(subject.parse("9 ft 6 in 2 cm").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 ' 6 \" 2 cm").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 foot 6 inch 2 centimeter").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 foot 6 inch 2 centimetre").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 feet 6 inches 2 centimeters").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 feet 6 inches 2 centimetres").to_s).to eq("9.565616797900262 ft")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { subject.parse("5 feets 6 inches") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 feets 6 inche").to_s }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 foots 6 inched").to_s }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 fts 6 ines").to_s }.to raise_error(Unitify::ParseError)

        expect { subject.parse("6 ms 50 cms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("6 meterss 50 centimeterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("6 metrez 50 centimetrez") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("6 metrez 50 centimetrez") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("9 feets 6 inches 2 cms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("9 feets 6 inche 50 centimeterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("9 foots 6 inched 50 centimetrez") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("9 fts 6 ines centimetrez") }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
