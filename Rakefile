require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
require 'yard'
require 'yard/rake/yardoc_task'


# Run test by default.
task :default => :rspec
task :test => :rspec


Bundler::GemHelper.install_tasks


# Run all the specs in the /spec folder
RSpec::Core::RakeTask.new(:rspec)


YARD::Rake::YardocTask.new(:yardoc) do |y|
  y.options = ["--output-dir", "yardoc"]
end


desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r freeagent.rb"
end
