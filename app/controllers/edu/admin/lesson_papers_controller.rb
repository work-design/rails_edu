class Edu::Admin::LessonPapersController < Edu::Admin::BaseController
  before_action :set_lesson
  before_action :set_lesson_paper, only: [:show, :edit, :update, :add, :destroy]

  def index
    q_params = {
      lesson_id: params[:lesson_id]
    }.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:type)
    @lesson_papers = LessonPaper.default_where(q_params).page(params[:page])
  end

  def new
    @lesson_paper = LessonPaper.new(type: params[:type], lesson_id: params[:lesson_id])
  end

  def create
    @lesson_paper = LessonPaper.new(lesson_id: params[:lesson_id])
    @lesson_paper.assign_attributes lesson_paper_params

    if @lesson_paper.save
      redirect_to edu_lesson_papers_url(lesson_id: @lesson_paper.lesson_id), notice: 'Exam paper was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson_paper.update(lesson_paper_params)
      redirect_to edu_lesson_papers_url(lesson_id: @lesson_paper.lesson_id), notice: 'Exam paper was successfully updated.'
    else
      render :edit
    end
  end

  def add
    @lesson_paper.add

    redirect_to edu_lesson_papers_url(lesson_id: @lesson_paper.lesson_id)
  end

  def destroy
    @lesson_paper.destroy
    redirect_to edu_lesson_papers_url(lesson_id: @lesson_paper.lesson_id), notice: 'Exam paper was successfully destroyed.'
  end

  private
  def set_lesson
    if params[:lesson_id]
      @lesson = Lesson.find params[:lesson_id]
    end
  end

  def set_lesson_paper
    @lesson_paper = LessonPaper.find(params[:id])
  end

  def lesson_paper_params
    params.fetch(:lesson_paper, {}).permit(
      :title,
      :description,
      :link,
      :document,
      :type,
      :lesson_id
    )
  end

end
