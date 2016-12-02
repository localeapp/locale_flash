require File.expand_path("../lib/locale_flash/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "locale_flash"
  s.version     = LocaleFlash::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christopher Dell"]
  s.email       = ["chris@tigrish.com"]
  s.homepage    = "https://rubygems.org/gems/locale_flash"
  s.summary     = %q{Super charge your flash messages with I18n}
  s.description = %q{locale_flash lets you create flash messages easily with I18n fallbacks}
  s.license     = "Nonstandard"

  s.files         = `git ls-files lib`.split("\n")

  s.add_development_dependency "i18n", "~> 0.7"
  s.add_development_dependency "rake", "~> 11.3"
  s.add_development_dependency "rspec", "~> 3.5"
end
