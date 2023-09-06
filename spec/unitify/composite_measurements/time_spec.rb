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

      it "parses hours and minutes" do
        expect(subject.parse("3 h 45 min").to_s).to eq("3.75 h")
        expect(subject.parse("3 hr 45 min").to_s).to eq("3.75 h")
        expect(subject.parse("3 hour 45 minute").to_s).to eq("3.75 h")
        expect(subject.parse("3 hours 45 minutes").to_s).to eq("3.75 h")
      end

      it "parses days, hours, and minutes" do
        expect(subject.parse("7 d 12 h 15 min").to_s).to eq("7.510416666666667 d")
        expect(subject.parse("7 d 12 hr 15 min").to_s).to eq("7.510416666666667 d")
        expect(subject.parse("7 day 12 hour 15 minute").to_s).to eq("7.510416666666667 d")
        expect(subject.parse("7 days 12 hours 15 minutes").to_s).to eq("7.510416666666667 d")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { subject.parse("10:20") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("10:20,20:30").to_s }.to raise_error(Unitify::ParseError)
        expect { subject.parse("10:20,20,30").to_s }.to raise_error(Unitify::ParseError)

        expect { subject.parse("3 hs 45 mins") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 hourz 45 minutez") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 hou 45 minut") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("7 dz 12 hz 15 minz") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("7 dayz 12 hourz 15 minutez") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("7 d 12 hou 15 minue") }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
