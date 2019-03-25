require 'rails_com'
module RailsEdu
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/rails_edu",
      "#{config.root}/app/models/rails_edu/courses"
    ]

    config.factory_bot.definition_file_paths += Dir["#{config.root}/test/factories"] if defined?(FactoryBotRails)

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false
      }
      g.test_unit = {
        fixture: true,
        fixture_replacement: :factory_girl
      }
      g.scaffold_controller = {
        jbuilder: true
      }
      g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
    end

    initializer 'rails_edu.assets.precompile' do |app|
      app.config.assets.precompile += ['rails_edu_manifest.js']
    end

  end
end
