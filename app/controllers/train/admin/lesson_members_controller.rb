class TrainAdmin::LessonMembersController < TrainAdmin::BaseController
  before_action :set_lesson
  before_action :set_lesson_member, only: [:show, :edit, :update, :destroy]

  def index
    q_params = params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:id, :state)
    @lesson_members = @lesson.lesson_members.default_where(q_params).page(params[:page])

    respond_to do |format|
      format.html
    end
  end

  def members
    q_params = params.fetch(:q, {}).permit(:name, :office_id, :email, :department_id)
    q_params.merge! params.permit(:id, :email, :office_id)
    @lesson_members = @lesson.lesson_members.page(params[:page])
    @members = Member.includes(:office, :department, :lesson_members).default_where(q_params).page(params[:page])
  end

  def new
    @lesson_member = LessonMember.new
  end

  def create
    @lesson_member = LessonMember.new(lesson_member_params)

    if @lesson_member.save
      redirect_to lesson_members_url, notice: 'Lesson member was successfully created.'
    else
      render :new
    end
  end

  def update
    if @lesson_member.update(lesson_member_params)
      redirect_to lesson_members_url, notice: 'Lesson member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @lesson_member.destroy
    redirect_to train_lesson_members_url, notice: 'Lesson member was successfully destroyed.'
  end

  def check
    add_ids = params[:add_ids].split(',')
    if add_ids.present?
      members = Member.where(id: add_ids)
      members.each do |member|
        add = @lesson.lesson_members.find_or_initialize_by(member_id: member.id)
        add.save_with_remind
      end
    end

    remove_ids = params[:remove_ids].split(',')
    if remove_ids.present?
      @lesson.lesson_members.where(member_id: remove_ids).each do |pl|
        pl.destroy
      end
    end

    redirect_to train_lesson_lesson_members_url(@lesson)
  end

  def attend
    if params[:add_ids].present?
      adds = LessonMember.where(id: params[:add_ids].split(','))
      adds.update_all attended: true
    end

    if params[:remove_ids].present?
      removes = LessonMember.where(id: params[:remove_ids].split(','))
      removes.update_all attended: false
    end

    head :no_content
  end

  def show
    @lesson_member = LessonMember.find_by(id: params[:id])
    @training_histories = @lesson_member.training_histories.order('id desc')
  end

  def edit
    @title = "Assign Lessons"
  end

  def quit
    @lesson_member = LessonMember.find params[:id]
    @lesson_member.trigger_to! state: 'quitted'
    redirect_to train_lesson_lesson_members_url(member_id: @lesson_member.member_id)
  end

  private
  def set_lesson
    @lesson = Lesson.find params[:lesson_id]
  end

  def set_lesson_member
    @lesson_member = LessonMember.find(params[:id])
  end

  def lesson_member_params
    params.fetch(:lesson_member, {}).permit(:state)
  end

end
