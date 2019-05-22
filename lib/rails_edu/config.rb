require 'active_support/configurable'

module RailsEdu #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.my_controller = 'MyController'
    config.member_controller = 'MemberController'
    config.admin_controller = 'AdminController'
    config.disabled_models = []
  end

end


