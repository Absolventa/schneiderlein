$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "schneiderlein/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "schneiderlein"
  s.version     = Schneiderlein::VERSION
  s.authors     = ["Carsten Zimmermann", "Robin Neumann", "Daniel Schoppmann"]
  s.email       = ["cz@aegisnet.de", "robin.neumann@absolventa.de", "daniel.schoppmann@gmail.com"]
  s.homepage    = "https://github.com/Absolventa/schneiderlein"
  s.summary     = "Rack middleware that rescues from ActionDispatch::ParamsParser"
  s.description = "Rescues from ActionDispatch::ParamsParser and continues in middleware stack"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.required_ruby_version = '>= 3.0.0'

  s.add_dependency "rails", ">= 6.0.0", "< 8.0"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", '~> 5.1.2'
end
