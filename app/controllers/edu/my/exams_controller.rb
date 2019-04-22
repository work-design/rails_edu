class Edu::My::ExamsController < Edu::My::BaseController
  before_action :set_course, only: [:index, :new, :create]
  before_action :set_exam, only: [:show, :edit, :update, :finish, :destroy]

  def index
    @exams = @course.exams.where(member_id: current_member.id).page(params[:page])
    @course_papers = @course.course_papers.where.not(id: @exams.processing.pluck(:course_paper_id))
  end

  def certification
    q_params = {
      member_id: current_member.id,
      'course_paper.type': 'CertifiablePaper'
    }.with_indifferent_access
    @exams = Exam.default_where(q_params).page(params[:page])
    @course_papers = CertifiablePaper.where.not(id: @exams.pluck(:course_paper_id).uniq).page(params[:page])
  end

  def new
    @exam = Exam.new
  end

  def add
    @exam = current_member.exams.create(course_paper_id: params[:course_paper_id])
    @exam.reload
    @exam.custom_link
    #ExamGenerateJob.perform_later(@exam.id)

    if @exam.course_id
      redirect_to my_course_exams_url(@exam.course_id, course_paper_id: params[:course_paper_id])
    else
      redirect_to certification_my_exams_url
    end
  end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to my_course_exams_url(@course)
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
      redirect_to my_course_exams_url(@exam.course_id)
    else
      render :edit
    end
  end

  def finish
    @exam.set_finish
    if @exam.course_id
      redirect_to my_course_exams_url(@exam.course_id)
    else
      redirect_to cert_admin_exams_url
    end
  end

  def destroy
    @exam.destroy

    flash[:notice] = 'Exam was successfully destroyed.'
    if @exam.course_id
      redirect_to my_course_exams_url(@exam.course_id, course_paper_id: params[:course_paper_id])
    else
      redirect_to certification_my_exams_url
    end
  end

  private
  def set_course
    @course = Course.find params[:course_id]
  end

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.fetch(:exam, {}).permit(
      :course_paper_id
    )
  end

end
