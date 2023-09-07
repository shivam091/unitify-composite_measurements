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

      it "parses miles and yards" do
        expect(subject.parse("20 mi 220 yd").to_s).to eq("20.125 mi")
        expect(subject.parse("20 mile 220 yard").to_s).to eq("20.125 mi")
        expect(subject.parse("20 miles 220 yards").to_s).to eq("20.125 mi")
      end

      it "parses miles, yards, and feet" do
        expect(subject.parse("2 mi 1760 yd 8800 ft").to_s).to eq("4.66666666666667 mi")
        expect(subject.parse("2 mi 1760 yd 8800 '").to_s).to eq("4.66666666666667 mi")
        expect(subject.parse("2 mile 1760 yard 8800 foot").to_s).to eq("4.66666666666667 mi")
        expect(subject.parse("2 miles 1760 yards 8800 feet").to_s).to eq("4.66666666666667 mi")
      end

      it "parses kilometres and metres" do
        expect(subject.parse("5 km 500 m").to_s).to eq("5.5 km")
        expect(subject.parse("5 kilometer 500 meter").to_s).to eq("5.5 km")
        expect(subject.parse("5 kilometers 500 meters").to_s).to eq("5.5 km")
        expect(subject.parse("5 kilometre 500 metre").to_s).to eq("5.5 km")
        expect(subject.parse("5 kilometres 500 metres").to_s).to eq("5.5 km")
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

        expect { subject.parse("20 mis 220 yds") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("20 miless 220 yardss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("20 milez 220 yardz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("2 mis 1760 yds 8800 fts") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 miless 1760 yardss 8800 feets") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 milez 1760 yardz 8800 feetz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("5 kms 500 ms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 kilometerss 500 meterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 kilometerz 500 meterz") }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
