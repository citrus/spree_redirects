# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "spree_redirects"
  s.version     = '0.3.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen", "Michael Bianco"]
  s.email       = ["spencer@citrusme.com", "mike@cliffsidemedia.com"]
  s.homepage    = "https://github.com/citrus/spree_redirects"
  s.summary     = %q{Spree Redirects adds an interface for redirecting old url's to new ones.}
  s.description = %q{Spree Redirects adds an interface for redirecting old url's to new ones.}

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_runtime_dependency 'spree_core', '~> 1.1'

  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'rspec-rails', '2.12.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'capybara', '~> 1.1'
end
