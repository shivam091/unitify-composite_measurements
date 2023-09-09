# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/unitify/composite_measurements/length_spec.rb

RSpec.describe Unitify::CompositeMeasurements::Length do
  subject { described_class }

  describe "#parse" do
    context "when valid string is passed" do
      it "parses foot and inch" do
        expect(subject.parse("5 \' 6 \"").to_s).to eq("5.5 ft")
        expect(subject.parse("5 ft 6 in").to_s).to eq("5.5 ft")
        expect(subject.parse("5 foot 6 inch").to_s).to eq("5.5 ft")
        expect(subject.parse("5 feet 6 inches").to_s).to eq("5.5 ft")
      end

      it "parses metre and centimetre" do
        expect(subject.parse("6 m 50 cm").to_s).to eq("6.5 m")
        expect(subject.parse("6 meter 50 centimeter").to_s).to eq("6.5 m")
        expect(subject.parse("6 metre 50 centimetre").to_s).to eq("6.5 m")
        expect(subject.parse("6 meters 50 centimeters").to_s).to eq("6.5 m")
        expect(subject.parse("6 metres 50 centimetres").to_s).to eq("6.5 m")
      end

      it "parses mile and yard" do
        expect(subject.parse("20 mi 220 yd").to_s).to eq("20.125 mi")
        expect(subject.parse("20 mile 220 yard").to_s).to eq("20.125 mi")
        expect(subject.parse("20 miles 220 yards").to_s).to eq("20.125 mi")
      end

      it "parses kilometre and metre" do
        expect(subject.parse("5 km 500 m").to_s).to eq("5.5 km")
        expect(subject.parse("5 kilometer 500 meter").to_s).to eq("5.5 km")
        expect(subject.parse("5 kilometers 500 meters").to_s).to eq("5.5 km")
        expect(subject.parse("5 kilometre 500 metre").to_s).to eq("5.5 km")
        expect(subject.parse("5 kilometres 500 metres").to_s).to eq("5.5 km")
      end

      it "parses mile, yard, and foot" do
        expect(subject.parse("2 mi 1760 yd 8800 ft").to_s).to eq("4.66666666666667 mi")
        expect(subject.parse("2 mi 1760 yd 8800 '").to_s).to eq("4.66666666666667 mi")
        expect(subject.parse("2 mile 1760 yard 8800 foot").to_s).to eq("4.66666666666667 mi")
        expect(subject.parse("2 miles 1760 yards 8800 feet").to_s).to eq("4.66666666666667 mi")
      end

      it "parses foot, inch, and centimetre" do
        expect(subject.parse("9 ft 6 in 2 cm").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 ' 6 \" 2 cm").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 foot 6 inch 2 centimeter").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 foot 6 inch 2 centimetre").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 feet 6 inches 2 centimeters").to_s).to eq("9.565616797900262 ft")
        expect(subject.parse("9 feet 6 inches 2 centimetres").to_s).to eq("9.565616797900262 ft")
      end

      it "parses foot, inch, and yard" do
        expect(subject.parse("8 ft 10 in 5/16 yd").to_s).to eq("9.770833333333332 ft")
        expect(subject.parse("8 ' 10 \" 5/16 yd").to_s).to eq("9.770833333333332 ft")
        expect(subject.parse("8 foot 10 inch 5/16 yard").to_s).to eq("9.770833333333332 ft")
        expect(subject.parse("8 feet 10 inches 5/16 yards").to_s).to eq("9.770833333333332 ft")
      end

      it "parses mile, furlong, and yard" do
        expect(subject.parse("12 mi 3 fur 300 yd").to_s).to eq("12.545454545454545 mi")
        expect(subject.parse("12 mile 3 furlong 300 yard").to_s).to eq("12.545454545454545 mi")
        expect(subject.parse("12 miles 3 furlongs 300 yards").to_s).to eq("12.545454545454545 mi")
      end

      it "parses chain, foot, and inch" do
        expect(subject.parse("1 ch 66 ft 792 in").to_s).to eq("3 ch")
        expect(subject.parse("1 ch 66 ' 792 \"").to_s).to eq("3 ch")
        expect(subject.parse("1 chain 66 foot 792 inch").to_s).to eq("3 ch")
        expect(subject.parse("1 chains 66 feet 792 inches").to_s).to eq("3 ch")
      end

      it "parses fathom, foot, and inch" do
        expect(subject.parse("2 ftm 12 ft 144 in").to_s).to eq("6 ftm")
        expect(subject.parse("2 ftm 12 ' 144 \"").to_s).to eq("6 ftm")
        expect(subject.parse("2 fathom 12 foot 144 inch").to_s).to eq("6 ftm")
        expect(subject.parse("2 fathoms 12 feet 144 inches").to_s).to eq("6 ftm")
      end

      it "parses furlong, chain, and foot" do
        expect(subject.parse("5 fur 40 ch 660 ft").to_s).to eq("10 fur")
        expect(subject.parse("5 fur 40 ch 660 '").to_s).to eq("10 fur")
        expect(subject.parse("5 furlong 40 chain 660 foot").to_s).to eq("10 fur")
        expect(subject.parse("5 furlongs 40 chains 660 feet").to_s).to eq("10 fur")
      end

      it "parses foot, inch, and millimetre" do
        expect(subject.parse("3 ft 6 in 90 mm").to_s).to eq("3.795275590551181 ft")
        expect(subject.parse("3 ' 6 \" 90 mm").to_s).to eq("3.795275590551181 ft")
        expect(subject.parse("3 foot 6 inch 90 millimeter").to_s).to eq("3.795275590551181 ft")
        expect(subject.parse("3 feet 6 inches 90 millimeters").to_s).to eq("3.795275590551181 ft")
        expect(subject.parse("3 foot 6 inch 90 millimetre").to_s).to eq("3.795275590551181 ft")
        expect(subject.parse("3 feet 6 inches 90 millimetres").to_s).to eq("3.795275590551181 ft")
      end

      it "parses kilometre, metre, and millimetre" do
        expect(subject.parse("9 km 500 m 3 mm").to_s).to eq("9.500003 km")
        expect(subject.parse("9 kilometer 500 meter 3 millimeter").to_s).to eq("9.500003 km")
        expect(subject.parse("9 kilometers 500 meters 3 millimeters").to_s).to eq("9.500003 km")
        expect(subject.parse("9 kilometre 500 metre 3 millimetre").to_s).to eq("9.500003 km")
        expect(subject.parse("9 kilometres 500 metres 3 millimetres").to_s).to eq("9.500003 km")
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

        expect { subject.parse("20 mis 220 yds") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("20 miless 220 yardss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("20 milez 220 yardz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("5 kms 500 ms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 kilometerss 500 meterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 kilometerz 500 meterz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("2 mis 1760 yds 8800 fts") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 miless 1760 yardss 8800 feets") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 milez 1760 yardz 8800 feetz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("9 feets 6 inches 2 cms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("9 feets 6 inche 50 centimeterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("9 foots 6 inched 50 centimetrez") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("9 fts 6 ines centimetrez") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("1 chs 66 fts 792 ins") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("1 chainss 66 feets 792 inchess") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("1 chainz 66 feetz 792 inchez") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("3 fts 6 ins 90 mms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 feetss 6 inchess 90 millimeterss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 feetz 6 inchez 90 millimeterz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("2 ftms 12 fts 144 ins") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 fathomss 12 feets 144 inchess") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 fathomz 12 feetz 144 inchez") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("5 furs 40 chs 660 fts") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 furlongss 40 chainss 660 feets") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("5 furlongz 40 chainz 660 feetz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("9 kms 500 ms 3 mms") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("9 kilometress 500 metress 3 millimetress") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("9 kilometrez 500 metrez 3 millimetrez") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("12 mis 3 furs 300 yds") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("12 miless 3 furlongss 300 yardss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("12 milez 3 furlongz 300 yardz") }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
