$:.push File.expand_path('lib', __dir__)
require 'rails_train/version'

Gem::Specification.new do |s|
  s.name = 'rails_train'
  s.version = RailsTrain::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_train'
  s.summary = ' Summary of RailsDoc.'
  s.description = ' Description of RailsDoc.'
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails', '>= 5.2'

  s.add_development_dependency 'sqlite3'
end
