# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'hookly/version'

Gem::Specification.new do |s|
  s.name        = 'hookly'
  s.version     = Hookly::VERSION
  s.authors     = ['Brian Norton']
  s.email       = ['brian.nort@gmail.com']
  s.homepage    = 'https://github.com/bnorton/hookly-rails'
  s.summary     = %q{hookly.js asset pipeline provider/wrapper. Ruby wrapper for the Hookly API}
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'webmock', '~> 1.21'

  s.add_dependency 'typhoeus', '~> 0.7'
end
