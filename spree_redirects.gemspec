# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_redirects/version"

Gem::Specification.new do |s|
  s.name        = "spree_redirects"
  s.version     = SpreeRedirects::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/spree_redirects"
  s.summary     = %q{Spree Redirects adds an interface for redirecting old url's to new ones.}
  s.description = %q{Spree Redirects adds an interface for redirecting old url's to new ones.}

  s.rubyforge_project = "spree_redirects"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('spree_core', '~> 1.0.0')
  
  s.add_development_dependency('dummier',      '~> 0.3.0')
  s.add_development_dependency('shoulda',      '~> 3.0.0')
  s.add_development_dependency('factory_girl', '~> 2.6.0')
  s.add_development_dependency('capybara',     '~> 1.1.2')
  s.add_development_dependency('sqlite3',      '~> 1.3.5')

end
