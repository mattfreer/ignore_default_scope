$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ignore_default_scope/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ignore_default_scope"
  s.version     = IgnoreDefaultScope::VERSION
  s.authors     = ["Matt Freer"]
  s.email       = ["matt.freer@gmail.com"]
  s.homepage    = "https://github.com/mattfreer/ignore_default_scope"
  s.summary     = "A Ruby on Rails plug-in that provides a mechanism for ActiveRecord Models to ignore the default_scope of a belongs_to association."
  s.description = "Instruct an ActiveRecord Model to ignore the default_scope of a belongs_to association"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.1.1"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "timecop"
end
