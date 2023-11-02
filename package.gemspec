Gem::Specification.new do |s|
  s.name = 'rails_edu'
  s.version = '0.0.1'
  s.authors = ['Mingyuan Qin']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_edu'
  s.summary = 'Summary of RailsDoc.'
  s.description = 'Description of RailsDoc.'
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_dependency 'rails_profile'
  s.add_development_dependency 'sqlite3'
end
