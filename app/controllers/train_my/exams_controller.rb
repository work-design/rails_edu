class TrainMy::ExamsController < TrainMy::BaseController
  before_action :set_lesson, only: [:index, :new, :create]
  before_action :set_exam, only: [:show, :edit, :update, :finish, :destroy]

  def index
    @exams = @lesson.exams.where(member_id: current_member.id).page(params[:page])
    @lesson_papers = @lesson.lesson_papers.where.not(id: @exams.processing.pluck(:lesson_paper_id))
  end

  def certification
    q_params = {
      member_id: current_member.id,
      'lesson_paper.type': 'CertifiablePaper'
    }.with_indifferent_access
    @exams = Exam.default_where(q_params).page(params[:page])
    @lesson_papers = CertifiablePaper.where.not(id: @exams.pluck(:lesson_paper_id).uniq).page(params[:page])
  end

  def new
    @exam = Exam.new
  end

  def add
    @exam = current_member.exams.create(lesson_paper_id: params[:lesson_paper_id])
    @exam.reload
    @exam.custom_link
    #ExamGenerateJob.perform_later(@exam.id)

    if @exam.lesson_id
      redirect_to my_lesson_exams_url(@exam.lesson_id, lesson_paper_id: params[:lesson_paper_id])
    else
      redirect_to certification_my_exams_url
    end
  end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to my_lesson_exams_url(@lesson), notice: 'Exam was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @exam.update(exam_params)
      redirect_to my_lesson_exams_url(@exam.lesson_id), notice: 'Exam was successfully updated.'
    else
      render :edit
    end
  end

  def finish
    @exam.set_finish
    if @exam.lesson_id
      redirect_to my_lesson_exams_url(@exam.lesson_id)
    else
      redirect_to cert_train_exams_url
    end
  end

  def destroy
    @exam.destroy

    flash[:notice] = 'Exam was successfully destroyed.'
    if @exam.lesson_id
      redirect_to my_lesson_exams_url(@exam.lesson_id, lesson_paper_id: params[:lesson_paper_id])
    else
      redirect_to certification_my_exams_url
    end
  end

  private
  def set_lesson
    @lesson = Lesson.find params[:lesson_id]
  end

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.fetch(:exam, {}).permit(
      :lesson_paper_id
    )
  end

end