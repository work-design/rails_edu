class Edu::Admin::HomeController < Edu::Admin::BaseController

  def index
    respond_to do |format|
      format.html
      format.html.phone
    end
  end


end
