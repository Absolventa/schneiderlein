$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "schneiderlein/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "schneiderlein"
  s.version     = Schneiderlein::VERSION
  s.authors     = ["Carsten Zimmermann"]
  s.email       = ["cz@aegisnet.de"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Schneiderlein."
  s.description = "TODO: Description of Schneiderlein."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.1.5", "< 5.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
