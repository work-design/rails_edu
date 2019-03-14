class Edu::Admin::CourseMembersController < Edu::Admin::BaseController
  before_action :set_course
  before_action :set_course_member, only: [:show, :edit, :update, :destroy]

  def index
    q_params = params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:id, :state)
    @course_members = @course.course_members.default_where(q_params).page(params[:page])

    respond_to do |format|
      format.html
    end
  end

  def members
    q_params = params.fetch(:q, {}).permit(:name, :office_id, :email, :department_id)
    q_params.merge! params.permit(:id, :email, :office_id)
    @course_members = @course.course_members.page(params[:page])
    @members = Member.includes(:office, :department, :course_members).default_where(q_params).page(params[:page])
  end

  def new
    @course_member = CourseMember.new
  end

  def create
    @course_member = CourseMember.new(course_member_params)

    if @course_member.save
      redirect_to course_members_url, notice: 'Course member was successfully created.'
    else
      render :new
    end
  end

  def update
    if @course_member.update(course_member_params)
      redirect_to course_members_url, notice: 'Course member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course_member.destroy
    redirect_to admin_course_members_url, notice: 'Course member was successfully destroyed.'
  end

  def check
    add_ids = params[:add_ids].split(',')
    if add_ids.present?
      members = Member.where(id: add_ids)
      members.each do |member|
        add = @course.course_members.find_or_initialize_by(member_id: member.id)
        add.save_with_remind
      end
    end

    remove_ids = params[:remove_ids].split(',')
    if remove_ids.present?
      @course.course_members.where(member_id: remove_ids).each do |pl|
        pl.destroy
      end
    end

    redirect_to admin_course_course_members_url(@course)
  end

  def attend
    if params[:add_ids].present?
      adds = CourseMember.where(id: params[:add_ids].split(','))
      adds.update_all attended: true
    end

    if params[:remove_ids].present?
      removes = CourseMember.where(id: params[:remove_ids].split(','))
      removes.update_all attended: false
    end

    head :no_content
  end

  def show
    @course_member = CourseMember.find_by(id: params[:id])
    @eduing_histories = @course_member.eduing_histories.order('id desc')
  end

  def edit
    @title = "Assign Courses"
  end

  def quit
    @course_member = CourseMember.find params[:id]
    @course_member.trigger_to! state: 'quitted'
    redirect_to admin_course_course_members_url(member_id: @course_member.member_id)
  end

  private
  def set_course
    @course = Course.find params[:course_id]
  end

  def set_course_member
    @course_member = CourseMember.find(params[:id])
  end

  def course_member_params
    params.fetch(:course_member, {}).permit(:state)
  end

end
