require 'rubygems'
require 'bundler/gem_tasks'

Bundler.setup(:default, :development)

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop spec]
