require 'active_support/configurable'

module RailsEdu #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_class = 'ApplicationController'
    config.my_class = 'MyController'
    config.admin_class = 'AdminController'
    config.panel_class = 'PanelController'
    config.disabled_models = []
  end

end


