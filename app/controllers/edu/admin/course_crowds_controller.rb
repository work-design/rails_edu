class Edu::Admin::CourseCrowdsController < Edu::Admin::BaseController
  before_action :set_course
  before_action :set_course_crowds
  before_action :set_course_crowd, only: [:edit, :update, :destroy]

  def index
    q_params = default_params.merge! params.fetch(:q, {}).permit(:name, :office_id, :email, :department_id)
    q_params.merge! params.permit(:id, :email, :office_id)
    @course_crowds = @course.course_crowds.includes(crowd: :students)
  end

  def new
    @course_crowd = @course.course_crowds.build
    @crowds = Crowd.default_where(default_params).where.not(id: @course.crowd_ids)
  end

  def create
    @course_crowd = @course.course_crowds.find_or_initialize_by(crowd_id: course_crowd_params[:crowd_id])

    respond_to do |format|
      if @course_crowd.save
        format.html.phone
        format.html { redirect_to admin_course_course_crowds_url(@course) }
        format.js { redirect_to admin_course_course_crowds_url(@course) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_to admin_course_course_crowds_url(@course) }
        format.json { render :show }
      end
    end
  end

  def edit
  end

  def update
    @course_crowd.assign_attributes(course_crowd_params)

    respond_to do |format|
      if @course_crowd.save
        format.html.phone
        format.html { redirect_to admin_course_course_crowds_url(@course) }
        format.js { redirect_back fallback_location: admin_course_course_crowds_url(@course) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_course_course_crowds_url(@course) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @course_crowd.destroy

    redirect_to admin_course_course_crowds_url(@course)
  end

  private
  def set_course_crowds
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:id, :email, :name, :office_id, :email)
    @course_crowds = @course.course_crowds
    @crowds = Crowd.includes(crowd_students: :student).default_where(q_params).page(params[:page])

    @course_students = @course.course_students.page(params[:page])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_course_crowd
    @course_crowd = @course.course_crowds.find params[:id]
  end

  def course_crowd_params
    params.fetch(:course_crowd, {}).permit(
      :crowd_id,
      :teacher_id
    )
  end

end
