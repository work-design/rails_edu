class Edu::CoursesController < Edu::BaseController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    q_params = default_params
    @courses = Course.default_where(q_params).page(params[:page])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html.phone
        format.html { redirect_to edu_courses_url }
        format.js { redirect_back fallback_location: edu_courses_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: edu_courses_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @course.assign_attributes(course_params)

    respond_to do |format|
      if @course.save
        format.html.phone
        format.html { redirect_to edu_courses_url }
        format.js { redirect_back fallback_location: edu_courses_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: edu_courses_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @course.destroy
    redirect_to edu_courses_url
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.fetch(:course, {}).permit(
    )
  end

end
