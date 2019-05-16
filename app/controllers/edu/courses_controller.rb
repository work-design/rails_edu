class Edu::CoursesController < Edu::BaseController
  before_action :set_course, only: [:show]

  def index
    q_params = default_params
    @courses = Course.default_where(q_params).page(params[:page])
  end

  def show
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

end
