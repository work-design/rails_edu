$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "rails_doc/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_doc"
  s.version     = RailsDoc::VERSION
  s.authors     = ["qinmingyuan"]
  s.email       = ["mingyuan0715@foxmail.com"]
  s.homepage    = 'https://github.com/yougexiangfa/rails_doc'
  s.summary     = " Summary of RailsDoc."
  s.description = " Description of RailsDoc."
  s.license     = "MIT"

  s.files = Dir[
    "{app,config,db,lib}/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md"
  ]

  s.add_dependency "rails", "~> 5.2.1"

  s.add_development_dependency "sqlite3"
end
