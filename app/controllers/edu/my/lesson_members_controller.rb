class Edu::My::LessonMembersController < Edu::My::BaseController
  before_action :set_lesson_member, only: [:show, :edit, :update, :edit_quit, :update_quit, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit('lesson.lesson_taxon_id', 'lesson.type', 'lesson.title-asc', :state)
    @lesson_members = current_member.lesson_members.includes(:lesson).default_where(q_params).page(params[:page])
  end

  def new
    @lesson_member = current_member.lesson_members.build
  end

  def create
    if params[:lesson_id]
      @lesson_member = current_member.lesson_members.build(lesson_id: params[:lesson_id])
    else
      @lesson_member = current_member.lesson_members.build(lesson_member_params)
    end

    if @lesson_member.save_with_remind
      redirect_to my_lesson_members_url, notice: 'Lesson member was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson_member.update(lesson_member_params)
      redirect_to my_lesson_members_url, notice: 'Lesson member was successfully updated.'
    else
      render :edit
    end
  end

  def edit_quit
  end

  def update_quit
    @lesson_member.quit_note = lesson_member_params[:quit_note]
    @lesson_member.trigger_to! state: 'request_quit'
  end

  def destroy
    @lesson_member.destroy
    redirect_to my_lesson_members_url, notice: 'Lesson member was successfully destroyed.'
  end

  private
  def set_lesson_member
    @lesson_member = LessonMember.find(params[:id])
  end

  def lesson_member_params
    params.fetch(:lesson_member, {}).permit(:lesson_id, :quit_note)
  end

end
