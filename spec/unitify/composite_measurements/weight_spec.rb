# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# spec/unitify/composite_measurements/weight_spec.rb

RSpec.describe Unitify::CompositeMeasurements::Weight do
  subject { described_class }

  describe "#parse" do
    context "when valid string is passed" do
      it "parses pounds and ounces" do
        expect(subject.parse("8 lb 12 oz").to_s).to eq("8.75 lb")
        expect(subject.parse("8 lbs 12 ounce").to_s).to eq("8.75 lb")
        expect(subject.parse("8 lbm 12 ounce").to_s).to eq("8.75 lb")
        expect(subject.parse("8 # 12 ounce").to_s).to eq("8.75 lb")
        expect(subject.parse("8 pound 12 ounce").to_s).to eq("8.75 lb")
        expect(subject.parse("8 pounds 12 ounces").to_s).to eq("8.75 lb")
        expect(subject.parse("8 pound-mass 12 oz").to_s).to eq("8.75 lb")
      end

      it "parses stones and pounds" do
        expect(subject.parse("2 st 6 lb").to_s).to eq("2.428571428571429 st")
        expect(subject.parse("2 st 6 lbs").to_s).to eq("2.428571428571429 st")
        expect(subject.parse("2 stone 6 lbm").to_s).to eq("2.428571428571429 st")
        expect(subject.parse("2 stone 6 #").to_s).to eq("2.428571428571429 st")
        expect(subject.parse("2 stones 6 pound").to_s).to eq("2.428571428571429 st")
        expect(subject.parse("2 stones 6 pounds").to_s).to eq("2.428571428571429 st")
      end

      it "parses kilogrammes and grammes" do
        expect(subject.parse("4 kg 500 g").to_s).to eq("4.5 kg")
        expect(subject.parse("4 kilogramme 500 gramme").to_s).to eq("4.5 kg")
        expect(subject.parse("4 kilogrammes 500 grammes").to_s).to eq("4.5 kg")
        expect(subject.parse("4 kilogram 500 gram").to_s).to eq("4.5 kg")
        expect(subject.parse("4 kilograms 500 grams").to_s).to eq("4.5 kg")
      end
    end

    context "when invalid string is passed" do
      it "raises an error" do
        expect { subject.parse("8 lb 12 ozz") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 lbb 12 ozz") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 ## 12 ounces") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 lbms 12 oz") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 lbms 12 oz") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 poundss 12 ouncess") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("8 lbs 12 ounc") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("2 sts 6 lbs") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 stoness 6 poundss") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 st 6 pound mass") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 st 6 pound mass") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("2 st 6 ##") }.to raise_error(Unitify::ParseError)

        expect { subject.parse("4 kgs 500 gs") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("4 kilogramz 500 gramz") }.to raise_error(Unitify::ParseError)
        expect { subject.parse("4 kilograms 500 gramss") }.to raise_error(Unitify::ParseError)
      end
    end
  end
end
