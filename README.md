# Your First Ruby Gem of Many

Reticulates splines. [Live-coded](LIVE.md) at Flatiron School.

[![Build Status](https://travis-ci.org/dblock/frgom-prep.svg?branch=master)](https://travis-ci.org/dblock/frgom-prep)

## Install

Add to Gemfile.

```
gem 'frgom'
```

## Usage

### B-Splines

```ruby
spline = Frgom::Splines::B.new
spline.reticulate!
```

### Command Line

```ruby
$ frgom --verbose reticulate
Reticulating a Frgom::Splines::B ...
```

## License

Copyright (c) 2018 Daniel Doubrovkine and Contributors

This project is licensed under the MIT license. See [LICENSE](LICENSE.md) for details.
