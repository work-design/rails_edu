class Edu::Admin::CoursesController < Edu::Admin::BaseController
  before_action :set_course, only: [:show, :edit, :meet, :update, :destroy]

  def index
    q_params = default_params
    q_params.merge! params.permit(:type, :title, :course_taxon_id, 'id-desc', 'id-asc', 'title-asc')
    if current_member
      @courses = Course.default_where(q_params).page(params[:page])
    else
      @courses = Course.none.page
    end
  end

  def plan
    q_params = {
      teacher_id: current_member.id
    }
    q_params.merge! params.permit(:type, :course_taxon_id, 'id-desc', 'id-asc', 'title-asc')
    @courses = Course.default_where(q_params).page(params[:page])

    render 'index'
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to admin_courses_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to admin_course_url(@course) }
        format.js { redirect_to admin_courses_url }
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def meet

  end

  def destroy
    @course.destroy
    redirect_to admin_courses_url
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    p = params.fetch(:course, {}).permit(
      :course_taxon_id,
      :title,
      :description,
      :type,
      :position,
      :limit_number,
      :author_id,
      :teacher_id,
      :meeting_room,
      :repeat_type,
      :start_at,
      :finish_at,
      :compulsory,
      video: [],
      en_video: [],
      document: [],
      repeat_days: [],
      department_ids: []
    )
    p.merge! default_params
  end

end
