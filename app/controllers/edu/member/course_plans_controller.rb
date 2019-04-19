class Edu::Member::CoursePlansController < Edu::Member::BaseController
  before_action :set_course_plan, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {
      'booking_on-gte': Date.today,
      teacher_id: current_member.id
    }.with_indifferent_access
    q_params.merge! 'booking_on-gte': params[:start] if params[:start]
    q_params.merge! 'booking_on-lte': params[:finish] if params[:finish]

    q_params.merge! params.permit(:room_id)

    @course_plans = CoursePlan.includes(:room, :teacher, :course, :time_item, course_crowd: :crowd).default_where(q_params).order(booking_on: :asc).page(params[:page])

    respond_to do |format|
      format.html
      format.js
      format.json { render json: { events: @course_plans.map(&:to_event) } }
    end
  end

  def plan
    set_time_lists
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:room_id)
    @time_plans = @course_crowd.time_plans.default_where(q_params)

    @time_plan = @course_crowd.time_plans.find_or_initialize_by(q_params.slice(:room_id))
    @time_plan.time_list ||= TimeList.default
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
        format.html { redirect_to admin_course_crowd_plans_url(@course_crowd), notice: 'Course plan was successfully updated.' }
        format.js { redirect_back fallback_location: admin_course_crowd_plans_url(@course_crowd) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_course_crowd_plans_url(@course_crowd) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @course_plan.destroy
    redirect_to admin_course_crowd_plans_url(@course_crowd), notice: 'Course plan was successfully destroyed.'
  end

  private
  def set_course_plan
    @course_plan = CoursePlan.find(params[:id])
  end

  def course_plan_params
    params.fetch(:course_plan, {}).permit(
      :lesson_id,
      :room_id
    )
  end

end
