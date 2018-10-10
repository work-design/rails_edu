class TrainAdmin::HomeController < TrainAdmin::BaseController
  before_action :check_variant

  def index
    respond_to do |format|
      format.html
      format.html.phone
    end
  end


end
