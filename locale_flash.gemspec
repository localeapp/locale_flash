# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "locale_flash/version"

Gem::Specification.new do |s|
  s.name        = "locale_flash"
  s.version     = LocaleFlash::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christopher Dell"]
  s.email       = ["chris@tigrish.com"]
  s.homepage    = ""
  s.summary     = %q{Super charge your flash messages with I18n}
  s.description = %q{locale_flash lets you create flash messages easily with I18n fallbacks}

  s.rubyforge_project = "locale_flash"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec')
end
