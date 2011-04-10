# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "freeagent/version"

Gem::Specification.new do |s|
  s.name        = "freeagent"
  s.version     = Freeagent::VERSION
  s.summary     = ""
  s.description = ""

  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.8.7"

  s.authors     = ["Simone Carletti"]
  s.email       = ["weppos@weppos.net"]
  s.homepage    = ""

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("rspec", "~> 2.5.0")
  s.add_development_dependency("yard")
end
