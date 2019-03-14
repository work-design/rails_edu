class Edu::My::CourseMembersController < Edu::My::BaseController
  before_action :set_course_member, only: [:show, :edit, :update, :edit_quit, :update_quit, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit('course.course_taxon_id', 'course.type', 'course.title-asc', :state)
    @course_members = current_member.course_members.includes(:course).default_where(q_params).page(params[:page])
  end

  def new
    @course_member = current_member.course_members.build
  end

  def create
    if params[:course_id]
      @course_member = current_member.course_members.build(course_id: params[:course_id])
    else
      @course_member = current_member.course_members.build(course_member_params)
    end

    if @course_member.save_with_remind
      redirect_to my_course_members_url, notice: 'Course member was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course_member.update(course_member_params)
      redirect_to my_course_members_url, notice: 'Course member was successfully updated.'
    else
      render :edit
    end
  end

  def edit_quit
  end

  def update_quit
    @course_member.quit_note = course_member_params[:quit_note]
    @course_member.trigger_to! state: 'request_quit'
  end

  def destroy
    @course_member.destroy
    redirect_to my_course_members_url, notice: 'Course member was successfully destroyed.'
  end

  private
  def set_course_member
    @course_member = CourseMember.find(params[:id])
  end

  def course_member_params
    params.fetch(:course_member, {}).permit(:course_id, :quit_note)
  end

end
