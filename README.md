# Unitify Composite Measurements

A set of specialized parsers for dealing with composite measurement strings.

[![Ruby](https://github.com/shivam091/unitify-composite_measurements/actions/workflows/main.yml/badge.svg)](https://github.com/shivam091/unitify-composite_measurements/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/unitify-composite_measurements.svg)](https://badge.fury.io/rb/unitify-composite_measurements)
[![Gem Downloads](https://img.shields.io/gem/dt/unitify-composite_measurements.svg)](http://rubygems.org/gems/unitify-composite_measurements)
[![Test Coverage](https://api.codeclimate.com/v1/badges/512f92c6eb5bc5853999/test_coverage)](https://codeclimate.com/github/shivam091/unitify-composite_measurements/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/512f92c6eb5bc5853999/maintainability)](https://codeclimate.com/github/shivam091/unitify-composite_measurements/maintainability)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/shivam091/unitify-composite_measurements/blob/main/LICENSE)

**Harshal V. Ladhe, M.Sc. Computer Science.**

## Minimum Requirements

* Ruby 3.2.2+ (https://www.ruby-lang.org/en/downloads/branches/)

## Installation

If using bundler, first add this line to your application's Gemfile:

```ruby
gem "unitify-composite_measurements"
```

And then execute:

`$ bundle install`

Or otherwise simply install it yourself as:

`$ gem install unitify-composite_measurements`

## Usage

Each packaged parser includes the `#parse` method for parsing composite measurements.
You can use an appropriate parser to parse measurements. The final result of `#parse`
is returned in the leftmost unit of your measurement.

This gem internally uses [`unitify`](https://github.com/shivam091/unitify) to
perform conversions and arithmetic operations. You can use any
[alias of the units](https://github.com/shivam091/unitify/blob/main/units.md) to build a
supported composite measurements.

```ruby
Unitify::CompositeMeasurements::Length.parse("5 feet 6 inches")
> #<Unitify::Length: 5.5 #<Unitify::Unit: ft (', feet, foot)>>
Unitify::CompositeMeasurements::Volume.parse("2 litres 250 millilitres")
> #<Unitify::Volume: 2.25 #<Unitify::Unit: l (L, liter, liters, litre, litres)>>
Unitify::CompositeMeasurements::Weight.parse("8 pound 12 ounce")
> #<Unitify::Weight: 8.75 #<Unitify::Unit: lb (#, lbm, lbs, pound, pound-mass, pounds)>>
Unitify::CompositeMeasurements::Time.parse("12:60:60,60")
> #<Unitify::Time: 13.016666683333334 #<Unitify::Unit: h (hour, hours, hr)>>
```

Each parser has capability to parse `real`, `rational`, `scientific`, and `complex` numbers.

```ruby
Unitify::CompositeMeasurements::Length.parse("1+2i ft 12 in")
> #<Unitify::Length: 2.0+2.0i #<Unitify::Unit: ft (', feet, foot)>>
Unitify::CompositeMeasurements::Length.parse("1.5 ft 12e2 in")
> #<Unitify::Length: 101.5 #<Unitify::Unit: ft (', feet, foot)>>
Unitify::CompositeMeasurements::Length.parse("1 1/2 ft 1+2i in")
> #<Unitify::Length: 1.5833333333333333+0.16666666666666669i #<Unitify::Unit: ft (', feet, foot)>>
Unitify::CompositeMeasurements::Length.parse("2 ft 1+2i in")
> #<Unitify::Length: 2.0833333333333335+0.16666666666666669i #<Unitify::Unit: ft (', feet, foot)>>
Unitify::CompositeMeasurements::Length.parse("1e-2 ft 1+2i in")
> #<Unitify::Length: 0.09333333333333334+0.16666666666666669i #<Unitify::Unit: ft (', feet, foot)>>
```

## Packaged parsers & supported composite measurements

There are tons of composite measurements that are bundled with `unitify-composite_measurements`.

**1. Unitify::CompositeMeasurements::Weight**
- pound-ounce (8 lb 12 oz)
- stone-pound (2 st 6 lb)
- kilogramme-gramme (4 kg 500 g)
- tonne-kilogramme (1 t 500 kg)
- stone-pound-ounce (14 st 2 lb 5 oz)

**2. Unitify::CompositeMeasurements::Length**
- foot-inch (5 ft 6 in)
- metre-centimetre (6 m 50 cm)
- kilometre-metre (6 m 50 cm)
- mile-yard (20 mi 220 yd)
- mile-yard-foot (2 mi 1760 yd 8800 ft)
- foot-inch-centimetre (9 ft 6 in 2 cm)

**3. Unitify::CompositeMeasurements::Volume**
- litre-millilitre (2 l 250 ml)

**4. Unitify::CompositeMeasurements::Time**
- hour-minute (3 h 45 min)
- minute-second (10 min 90 s)
- week-day (8 wk 3 d)
- month-day (2 mo 60 d)
- year-month (3 yr 4 mo)
- quarter-month (3 qtr 3 mo)
- fortnight-day (3 fn 42 d)
- day-hour-minute (7 d 12 h 15 min)
- hour-minute-second-microsecond (12:60:60,60)

**5. Unitify::CompositeMeasurements::Area**
- acre-square_metre (2 ac 200 m²)
- square_foot-square_inch (7 ft² 48 in²)
- square_foot-square_metre (500 ft² 46.45 m²)

### Specifing parsers

By default, `unitify-composite_measurements` ships with all the packaged parsers and this happens automatically
when you require the gem in the following manner.

```ruby
require "unitify/composite_measurements"
```

You can also use parsers in your application as per your need as:

```ruby
require "unitify/composite_measurements/base"

require "unitify/composite_measurements/length"
require "unitify/composite_measurements/weight"
require "unitify/composite_measurements/volume"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright 2023 [Harshal V. LADHE](https://github.com/shivam091), Released under the [MIT License](http://opensource.org/licenses/MIT).
