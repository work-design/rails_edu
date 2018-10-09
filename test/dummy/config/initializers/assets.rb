Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths += [
  Rails.root.join('node_modules'),
  *Dir[File.expand_path('vendor/nondigest_assets/*', Rails.root)]
]

Rails.application.config.assets.precompile += [
  'footer.js'
]
