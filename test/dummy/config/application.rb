require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application


    config.active_record.sqlite3.represent_boolean_as_integer = true

  end
end