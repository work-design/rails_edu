class Edu::Admin::CoursePlansController < Edu::Admin::BaseController
  before_action :set_course_crowd
  before_action :set_course_plan, only: [:show, :edit, :update, :qrcode, :destroy]

  def index
    q_params = {
      'booking_on-gte': Date.today
    }
    q_params.merge! params.permit('booking_on-gte', 'booking_on-lte')
    @course_crowd.sync(start: q_params['booking_on-gte'], finish: q_params['booking_on-lte']) if q_params['booking_on-gte'] && q_params['booking_on-lte']
    @course_plans = @course_crowd.course_plans.includes(:wechat_response).default_where(q_params).order(booking_on: :asc).page(params[:page])
  end

  def plan
    set_time_lists
    q_params = {}.with_indifferent_access
    q_params.merge! params.permit(:room_id)
    @time_plans = @course_crowd.time_plans.default_where(q_params)

    @time_plan = @course_crowd.time_plans.recent || @course_crowd.time_plans.build
    @time_plan.time_list ||= TimeList.default
  end

  def sync
    @course_crowd.sync

    redirect_to admin_course_crowd_plans_url(@course_crowd)
  end

  def new
    @course_plan = @course_crowd.course_plans.build
  end

  def create
    @course_plan = @course_crowd.course_plans.build(course_plan_params)

    respond_to do |format|
      if @course_plan.save
        format.html.phone
        format.html { redirect_to admin_course_crowd_plans_url(@course_crowd) }
        format.js { redirect_back fallback_location: admin_course_crowd_plans_url(@course_crowd) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_course_crowd_plans_url(@course_crowd) }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
    @rooms = Room.default_where(default_params)
  end

  def update
    @course_plan.assign_attributes(course_plan_params)

    respond_to do |format|
      if @course_plan.save
        format.html.phone
        format.html { redirect_to admin_course_crowd_plans_url(@course_crowd) }
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
  
  def qrcode
    wechat_config = current_organ.wechat_configs.first
    unless @course_plan.wechat_response
      @course_plan.create_wechat_response(type: 'TempScanResponse', valid_response: '签到成功', wechat_config_id: wechat_config.id) if wechat_config
    end
    redirect_to admin_course_crowd_plans_url(@course_crowd)
  end

  def destroy
    @course_plan.destroy
    redirect_to admin_course_crowd_plans_url(@course_crowd)
  end

  private
  def set_course_crowd
    @course_crowd = CourseCrowd.find params[:course_crowd_id]
  end

  def set_course_plan
    @course_plan = CoursePlan.find(params[:id])
  end

  def course_plan_params
    params.fetch(:course_plan, {}).permit(
      :lesson_id,
      :room_id,
      :teacher_id
    )
  end

end
