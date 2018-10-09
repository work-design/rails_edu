class My::BaseController < ApplicationController
  include RailsAuthController
  before_action :require_login_from_session

  default_form_builder 'MyFormBuilder' do |config|

  end

end
