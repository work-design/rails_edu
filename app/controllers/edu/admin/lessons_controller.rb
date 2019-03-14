class Edu::Admin::LessonsController < Edu::Admin::BaseController
  before_action :set_lesson, only: [:show, :edit, :meet, :repeat_form, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:repeat_form]

  def index
    q_params = params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:type, :lesson_taxon_id, 'id-desc', 'id-asc', 'title-asc')
    if current_teacher
      @lessons = Lesson.default_where(q_params).permit_with(current_teacher).page(params[:page])
    else
      @lessons = Lesson.none.page
    end
  end

  def all
    q_params = params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:type, :lesson_taxon_id, 'id-desc', 'id-asc', 'title-asc')
    @lessons = Lesson.default_where(q_params).page(params[:page])

    render 'index'
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      redirect_to edu_lessons_url, notice: 'Lesson was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to edu_lesson_url(@lesson), notice: 'Lesson was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def meet

  end

  def destroy
    @lesson.destroy
    redirect_to edu_lessons_url, notice: 'Lesson was successfully destroyed.'
  end

  private
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.fetch(:lesson, {}).permit(
      :lesson_taxon_id,
      :title,
      :description,
      :type,
      :position,
      :limit_people,
      :author_id,
      :lecturer_id,
      :meeting_room,
      :repeat_type,
      :start_at,
      :finish_at,
      :compulsory,
      video: [],
      en_video: [],
      document: [],
      repeat_days: [],
      department_ids: []
    )
  end

end
