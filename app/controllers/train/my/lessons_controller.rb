class TrainMy::LessonsController < TrainMy::BaseController
  before_action :set_lesson, only: [:show, :edit]

  def index
    l_params = {
      'lesson.type': params[:type],
      'lesson.lesson_taxon_id': params[:lesson_taxon_id],
      'lesson.title-asc': params['title-asc']
    }
    @lesson_members = current_member.lesson_members.includes(:lesson).default_where(l_params)

    q_params = params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:type, 'title-asc', :lesson_taxon_id)
    q_params.merge! 'id-not': @lesson_members.pluck(:lesson_id)
    # if current_member.department
    #   @lessons = current_member.department.lessons.default_where(q_params).page(params[:page])
    # else
      @lessons = Lesson.outward.default_where(q_params).page(params[:page])
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
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

end
