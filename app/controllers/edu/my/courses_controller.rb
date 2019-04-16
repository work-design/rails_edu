class Edu::My::CoursesController < Edu::My::BaseController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    q_params = default_params
    @courses = Course.default_where(q_params).page(params[:page])
  end

  def plan
    @rooms = current

    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:room_id)
    @time_plans = TimePlan.default_where(q_params)
    @events = @time_plans.map do |time_plan|
      time_plan.next_events
    end.flatten

    respond_to do |format|
      format.html
      format.js
      format.json { render json: { events: @events } }
    end
  end


  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html.phone
        format.html { redirect_to edu_courses_url, notice: 'Course was successfully created.' }
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
        format.html { redirect_to edu_courses_url, notice: 'Course was successfully updated.' }
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
    redirect_to edu_courses_url, notice: 'Course was successfully destroyed.'
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
