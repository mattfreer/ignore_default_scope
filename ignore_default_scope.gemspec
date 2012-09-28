$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ignore_default_scope/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ignore_default_scope"
  s.version     = IgnoreDefaultScope::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of IgnoreDefaultScope."
  s.description = "TODO: Description of IgnoreDefaultScope."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
end
