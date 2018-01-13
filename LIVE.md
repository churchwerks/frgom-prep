# Live Code

### Create a Folder

I organize all my code in source and since I often fork code from others to contribute, create a subfolder with the Github username, including mine.

```
$ mkdir ~/source/frgom
$ mkdir ~/source/frgom/dblock
$ cd ~/source/frgom/dblock
```

### Git

```
$ git init

Initialized empty Git repository in /Users/dblock/source/frgom/dblock/.git
```

### Create a Github Repo

Create a [new repository on Github](https://github.com/new).

Add it as a remote.

```
$ git remote add origin git@github.com:dblock/frgom.git
```

#### Create a Readme

Documentation is written in Markdown. Create and commit a _README.md_.

```
$ git add README.md
$ git commit -m "Added README."
[master acc5880] Added README.
1 file changed, 4 insertions(+)
create mode 100644 README.md
```

Push the README to Github.

```
$ git push origin master
Counting objects: 6, done.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (6/6), 963 bytes, done.
Total 6 (delta 0), reused 0 (delta 0)
To git@github.com:dblock/gf.git
* [new branch]      master -> master
```

#### Add a License

Every project needs a license. I use [the MIT license](https://github.com/dblock/frgom/blob/master/LICENSE.md) because it’s short and nobody has time to read licenses. Add a copyright notice to the README, don't forget future contributors.

```
Copyright (c) 2018, Daniel Doubrovkine and Contributors. All Rights Reserved.

This project is licensed under the MIT license. See [LICENSE](LICENSE.md) for details.
```

#### Gemfile

A Gemfile is something that comes with [Bundler](http://gembundler.com/) and declares gem dependencies.

Install Bundler.

```
$ gem install bundler
Fetching: bundler-1.3.5.gem (100%)
Successfully installed bundler-1.3.5
1 gem installed
Installing ri documentation for bundler-1.3.5...
Installing RDoc documentation for bundler-1.3.5...
```

Create a Gemfile. For now it just says where to get other gems from.

```ruby
source 'http://rubygems.org'
```

Run `bundle install`.

```
$ bundle install
Resolving dependencies...
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
```

#### .gitignore

The generated Gemfile.lock should not be included, create a _.gitignore_.

```
Gemfile.lock
```

#### Library

Create _lib/frgom.rb _and _lib/frgom/version.rb_.

```
require 'frgom/version'
```

```
module Frgom
  VERSION = '0.1.0'
end
```

#### Gem Declaration

A _gf.gemspec_ is a gem declaration.

```
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'frgom/version'

Gem::Specification.new do |s|
  s.name = 'frgom'
  s.version = Frgom::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/frgom'
  s.licenses = ['MIT']
  s.summary = 'First ruby gem of many.'
end
```

The declaration can be loaded in _Gemfile_, so that we can list dependencies in one place.

```
source 'http://rubygems.org'

gemspec
```

When running under Bundler, the _Gemfile_ will automatically be loaded, which will automatically load the gem specification.

```
$ bundle exec irb
1.9.3-p362 :001 > require 'frgom'
=> true
1.9.3-p362 :002 > Frgom::VERSION
=> "0.1.0"
```

#### Tests

You. Must. Test.

Add RSpec to _Gemfile_.

```
group :development, :test do
  gem 'rspec'
end
```

Tests need some setup, specifically to load the code in _lib_. Create _spec/spec_helper.rb_.

```
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'
require 'frgom'
```

Create a test in _spec/frgom/version_spec.rb_.

```
require 'spec_helper'

describe Frgom do
  it 'has a version' do
    expect(Frgom::VERSION).to_not be nil
  end
end
```

Add .rspec to pretty-print test output.

```
--format documentation
--color
```

#### Rakefile

Bundler comes with a number of Rake tasks to release a gem. Add Rake to Gemfile.

```
group :development, :test do
  gem 'rake'
end
```

Create a _Rakefile_.

```
require 'rubygems'
require 'bundler/gem_tasks'

Bundler.setup(:default, :development)
```

```
$ rake -T
rake build    # Build frgom-0.1.0.gem into the pkg directory.
rake install  # Build and install frgom-0.1.0.gem into system gems.
rake release  # Create tag v0.1.0 and build and push frgom-0.1.0.gem to Rubygems

$ rake build
frgom 0.1.0 built to pkg/frgom-0.1.0.gem.
```

Add `pkg/*` to `.gitignore`.

#### Default Rakefile to Running Tests

```
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: [:spec]
```

#### Travis-CI

Add _.travis.yml_, register the project on [travis-ci.org](https://travis-ci.org/) and add a badge.

```
rvm:
  - 2.4.1
```

```
[![Build Status](https://travis-ci.org/dblock/frgom.png)](https://travis-ci.org/dblock/gf)
```

#### Library Code

Your library should do something.

Create `fgrom/splines/b.rb`.

```
module Frgom
  module Splines
    class B
      def reticulated?
        !!@reticulated
      end

      def reticulate!
        @reticulated = true
      end
    end
  end
end
```

Create `fgrom/splines.rb`.

```
require_relative 'splines/b.rb'
```

Create `spec/fgrom/splines/b_spec.rb`.

```
require 'spec_helper'

describe Frgom::Splines::B do
  it 'is not reticulated by default' do
    expect(subject.reticulated?).to be false
  end
  context 'reticulated' do
    before do
      expect(subject.reticulate!).to be true
    end
    it 'is true' do
      expect(subject.reticulated?).to be true
    end
  end
end
```

#### Rubocop

Add RuboCop, Ruby style linter.

Add to Gemfile.

```
gem 'rubocop', '0.52.1'
```

Auto-generate a configuration.

```
$ rubocop -a
$ rubocop --auto-gen-config
```

Add to Rakefile.

```
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop spec]
```

#### Contributing

Add CONTRIBUTING.

#### Releasing

Add RELEASING.

#### Changelog

Create a CHANGELOG to list current and future updates.

```
### 0.1.0 (1/13/2018)

* Initial public release - [@dblock](https://github.com/dblock).
```

#### Release the Gem

```
$ rake release
```

#### Prepare for Next Release

Bump the version, add a _Next Release_ section to CHANGELOG.md.

### Adding a CLI

Add to `gemspec`.

```
s.executables << 'fgrom'
s.add_dependency 'gli'
```

Create `bin/frgom`.

```
#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'gli'
require 'frgom'

include GLI::App

program_desc 'Reticulate splines.'

switch [:v, :verbose], desc: 'Produce verbose output.', default_value: false

default_command :help

desc 'Reticulate a spline.'
command :reticulate do |c|
  c.flag [:k, :kind], desc: 'Kind of spline to reticulate.', default_value: 'Frgom::Splines::B'
  c.action do |global_options, options, _args|
    kind = options[:kind].split('::').reduce(Module, :const_get)
    puts "Reticulating a #{kind} ..." if global_options[:verbose]
    kind.new.reticulate!
    exit_now! nil
  end
end

exit run(ARGV)
```

Add tests.

```
require 'spec_helper'

describe 'Command Line' do
  let(:bin) { File.expand_path(File.join(__FILE__, '../../../bin/frgom')) }
  describe '#help' do
    let(:outpiut) { `"#{bin}" help` }
    it 'displays help' do
      expect(output).to include 'frgom - Reticulate splines.'
    end
  end
  describe '#reticulate' do
    let(:output) { `"#{bin}" --verbose reticulate` }
    it 'reticulates a b-spline' do
      expect(output).to eq "Reticulating a Frgom::Splines::B ...\n"
    end
  end
end
```

