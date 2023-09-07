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
You can use an appropriate parser to parse measurements.

This gem internally uses [`unitify`](https://github.com/shivam091/unitify) to
perform conversions and arithmetic operations.

You can use any [alias of the units](https://github.com/shivam091/unitify/blob/main/units.md) to build a supported composite measurements.
The final result of `#parse` is returned in the leftmost unit of your measurement.

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

## Packaged parsers & supported composite measurements

There are tons of composite measurements that are bundled with `unitify-composite_measurements`.

**1. Unitify::CompositeMeasurements::Weight**
- pounds-ounces (8 lb 12 oz)
- stones-pounds (2 st 6 lb)
- kilogrammes-grammes (4 kg 500 g)
- tonnes-kilogrammes (1 t 500 kg)
- stones-pounds-ounces (14 st 2 lb 5 oz)

**2. Unitify::CompositeMeasurements::Length**
- feet-inches (5 ft 6 in)
- metres-centimetres (6 m 50 cm)
- kilometres-metres (6 m 50 cm)
- miles-yards (20 mi 220 yd)
- miles-yards-feet (2 mi 1760 yd 8800 ft)
- feet-inches-centimetres (9 ft 6 in 2 cm)

**3. Unitify::CompositeMeasurements::Volume**
- litres-millilitres (2 l 250 ml)

**4. Unitify::CompositeMeasurements::Time**
- hours-minutes (3 h 45 min)
- minutes-seconds (10 min 90 s)
- weeks-days (8 wk 3 d)
- months-days (2 mo 60 d)
- years-months (3 yr 4 mo)
- quarters-months (3 qtr 3 mo)
- fortnights-days (3 fn 42 d)
- days-hours-minutes (7 d 12 h 15 min)
- hours-minutes-seconds-microseconds (12:60:60,60)

**5. Unitify::CompositeMeasurements::Area**
- acres-square_meters (2 ac 200 m²)
- square_feet-square_inches (7 ft² 48 in²)
- square_feet-square_meters (500 ft² 46.45 m²)

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
