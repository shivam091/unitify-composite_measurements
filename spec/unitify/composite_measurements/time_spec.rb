# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/unitify/composite_measurements/time_spec.rb

RSpec.describe Unitify::CompositeMeasurements::Time do
  subject { described_class }

  describe "#parse" do
    context "when valid string is passed" do
      it "parses hour and minute" do
        expect(subject.parse("3 h 45 min").to_s).to eq("3.75 h")
        expect(subject.parse("3 hr 45 min").to_s).to eq("3.75 h")
        expect(subject.parse("3 hour 45 minute").to_s).to eq("3.75 h")
        expect(subject.parse("3 hours 45 minutes").to_s).to eq("3.75 h")
      end

      it "parses minute and second" do
        expect(subject.parse("10 min 90 s").to_s).to eq("11.5 min")
        expect(subject.parse("10 min 90 sec").to_s).to eq("11.5 min")
        expect(subject.parse("10 minute 90 second").to_s).to eq("11.5 min")
        expect(subject.parse("10 minutes 90 seconds").to_s).to eq("11.5 min")
      end

      it "parses second and millisecond" do
        expect(subject.parse("8 s 500 ms").to_s).to eq("8.5 s")
        expect(subject.parse("8 sec 500 millisec").to_s).to eq("8.5 s")
        expect(subject.parse("8 second 500 millisecond").to_s).to eq("8.5 s")
        expect(subject.parse("8 seconds 500 milliseconds").to_s).to eq("8.5 s")
      end

      it "parses week and day" do
        expect(subject.parse("8 wk 3 d").to_s).to eq("8.428571428571429 wk")
        expect(subject.parse("8 week 3 day").to_s).to eq("8.428571428571429 wk")
        expect(subject.parse("8 weeks 3 days").to_s).to eq("8.428571428571429 wk")
      end

      it "parses month and day" do
        expect(subject.parse("2 mo 60 d").to_s).to eq("3.97260057797197 mo")
        expect(subject.parse("2 month 60 day").to_s).to eq("3.97260057797197 mo")
        expect(subject.parse("2 months 60 days").to_s).to eq("3.97260057797197 mo")
      end

      it "parses fortnight and day" do
        expect(subject.parse("3 fn 42 d").to_s).to eq("6 fn")
        expect(subject.parse("3 4tnite 42 d").to_s).to eq("6 fn")
        expect(subject.parse("3 fortnight 42 day").to_s).to eq("6 fn")
        expect(subject.parse("3 fortnights 42 days").to_s).to eq("6 fn")
      end

      it "parses year and month" do
        expect(subject.parse("3 yr 4 mo").to_s).to eq("3.333333333333333 yr")
        expect(subject.parse("3 y 4 mo").to_s).to eq("3.333333333333333 yr")
        expect(subject.parse("3 year 4 month").to_s).to eq("3.333333333333333 yr")
        expect(subject.parse("3 years 4 months").to_s).to eq("3.333333333333333 yr")
      end

      it "parses quarter and month" do
        expect(subject.parse("3 qtr 3 mo").to_s).to eq("4 qtr")
        expect(subject.parse("3 quarter 3 month").to_s).to eq("4 qtr")
        expect(subject.parse("3 quarters 3 months").to_s).to eq("4 qtr")
      end

      it "parses week, day, and hour" do
        expect(subject.parse("2 wk 3 d 6 h").to_s).to eq("2.464285714285715 wk")
        expect(subject.parse("2 wk 3 d 6 hr").to_s).to eq("2.464285714285715 wk")
        expect(subject.parse("2 week 3 day 6 hour").to_s).to eq("2.464285714285715 wk")
        expect(subject.parse("2 weeks 3 days 6 hours").to_s).to eq("2.464285714285715 wk")
      end

      it "parses month, week, and day" do
        expect(subject.parse("6 mo 2 wk 4 d").to_s).to eq("6.591780173391591 mo")
        expect(subject.parse("6 month 2 week 4 day").to_s).to eq("6.591780173391591 mo")
        expect(subject.parse("6 months 2 weeks 4 days").to_s).to eq("6.591780173391591 mo")
      end

      it "parses day, hour, and minute" do
        expect(subject.parse("7 d 12 h 15 min").to_s).to eq("7.510416666666667 d")
        expect(subject.parse("7 d 12 hr 15 min").to_s).to eq("7.510416666666667 d")
        expect(subject.parse("7 day 12 hour 15 minute").to_s).to eq("7.510416666666667 d")
        expect(subject.parse("7 days 12 hours 15 minutes").to_s).to eq("7.510416666666667 d")
      end

      it "parses year, month, and day" do
        expect(subject.parse("15 y 9 mo 20 d").to_s).to eq("15.804794460499222 yr")
        expect(subject.parse("15 yr 9 mo 20 d").to_s).to eq("15.804794460499222 yr")
        expect(subject.parse("15 year 9 month 20 day").to_s).to eq("15.804794460499222 yr")
        expect(subject.parse("15 years 9 months 20 days").to_s).to eq("15.804794460499222 yr")
      end

      it "parses hour, minute, and second" do
        expect(subject.parse("2 h 30 min 45 s").to_s).to eq("2.5125 h")
        expect(subject.parse("2 hr 30 min 45 sec").to_s).to eq("2.5125 h")
        expect(subject.parse("2 hour 30 minute 45 second").to_s).to eq("2.5125 h")
        expect(subject.parse("2 hours 30 minutes 45 seconds").to_s).to eq("2.5125 h")
      end

      it "parses duration" do
        expect(subject.parse("12:60:60,60").to_s).to eq("13.016666683333334 h")
        expect(subject.parse("12:60:60").to_s).to eq("13.016666666666667 h")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { subject.parse("3 hs 45 mins") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 hourz 45 minutez") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 hou 45 minut") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("10 mins 90 s") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("10 minutess 90 secs") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("10 minutez 90 secondz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("8 ss 500 mss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 secondss 500 millisecondss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 secondz 500 millisecondz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("8 wks 3 ds") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 weekss 3 dayss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 weekz 3 dayz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("2 mos 60 ds") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 monthss 60 dayss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 monthz 60 dayz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("3 yrs 4 mos") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 yearss 4 monthss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 yearz 4 monthz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("3 qtrs 3 mos") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 quarterss 3 monthss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 quarterz 3 monthz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("3 fns 42 ds") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 fortnightss 42 dayss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("3 fortnightz 42 dayz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("2 wkz 3 dz 6 hz") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 weekss 3 dayss 6 hourss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 weekz 3 dayz 6 hourz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("6 mos 2 wks 4 ds") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("6 monthss 2 weekss 4 dayss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("6 monthz 2 weekz 4 dayz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("7 dz 12 hz 15 minz") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("7 dayz 12 hourz 15 minutez") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("7 d 12 hou 15 minue") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("15 ys 9 mos 20 ds") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("15 yearss 9 monthss 20 dayss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("15 yearz 9 monthz 20 dayz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("2 hs 30 mins 45 ss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 hourss 30 minutess 45 secondss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 hourz 30 minutez 45 secondz") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("10:20") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("10:20,20:30").to_s }.to raise_error(Unitify::ParseError)
        expect { subject.parse("10:20,20,30").to_s }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
