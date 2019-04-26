class Edu::My::LessonsController < Edu::My::BaseController
  before_action :set_course, only: [:show, :edit]

  def index
    l_params = {
      'course.type': params[:type],
      'course.course_taxon_id': params[:course_taxon_id],
      'course.title-asc': params['title-asc']
    }
    @course_students = current_member.course_students.includes(:course).default_where(l_params)

    q_params = params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:type, 'title-asc', :course_taxon_id)
    q_params.merge! 'id-not': @course_students.pluck(:course_id)
    # if current_member.department
    #   @courses = current_member.department.courses.default_where(q_params).page(params[:page])
    # else
      @courses = Course.outward.default_where(q_params).page(params[:page])
    #end

    respond_to do |format|
      format.html
      format.html.phone { render 'index', layout: 'my_phone' }
    end
  end

  def show

    respond_to do |format|
      format.html
      format.html.phone { render 'show', layout: 'my_phone' }
    end
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

end
