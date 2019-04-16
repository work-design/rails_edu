class Edu::Admin::CoursePlansController < Edu::Admin::BaseController
  before_action :set_course
  before_action :set_course_plan, only: [:show, :edit, :update, :destroy]

  def index
    @course_plans = CoursePlan.page(params[:page])
  end

  def new
    @course_plan = @course.course_plans.build
  end

  def create
    @course_plan = @course.course_plans.build(course_plan_params)

    respond_to do |format|
      if @course_plan.save
        format.html.phone
        format.html { redirect_to admin_course_course_plans_url(@course), notice: 'Course plan was successfully created.' }
        format.js { redirect_back fallback_location: admin_course_course_plans_url(@course) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_course_course_plans_url(@course) }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @course_plan.assign_attributes(course_plan_params)

    respond_to do |format|
      if @course_plan.save
        format.html.phone
        format.html { redirect_to admin_course_course_plans_url(@course), notice: 'Course plan was successfully updated.' }
        format.js { redirect_back fallback_location: admin_course_course_plans_url(@course) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_course_course_plans_url(@course) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @course_plan.destroy
    redirect_to admin_course_course_plans_url(@course), notice: 'Course plan was successfully destroyed.'
  end

  private
  def set_course
    @course = Course.find params[:course_id]
  end

  def set_course_plan
    @course_plan = CoursePlan.find(params[:id])
  end

  def course_plan_params
    params.fetch(:course_plan, {}).permit(
      :lesson,
      :booking_on
    )
  end

end
