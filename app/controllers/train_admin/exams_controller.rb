class TrainAdmin::ExamsController < TrainAdmin::BaseController
  before_action :set_lesson_paper, except: [:todo, :cert]
  before_action :set_exam, only: [:show, :edit, :update, :score, :refer, :destroy]

  def index
    q_params = {
      'lesson_paper.type': ['ExamPaper', 'CertifiablePaper']
    }.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    @exams = @lesson_paper.exams.default_where(q_params).page(params[:page])
    @members = Member.where(id: @exams.pluck(:member_id).uniq)
  end

  def todo
    scope_ids = (current_member.tutee_ids + current_member.child_ids).uniq
    q_params = {
      member_id: scope_ids,
      'lesson_paper.type': ['ExamPaper', 'CertifiablePaper']
    }.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    @exams = Exam.default_where(q_params).page(params[:page])
    @members = Member.where(id: scope_ids)
    @lessons = Lesson.where(id: @exams.pluck(:lesson_id))

    render :todo, layout: 'my'
  end

  def cert
    q_params = {
      'lesson_paper.type': 'CertifiablePaper'
    }.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    @exams = current_member.review_exams.default_where(q_params).page(params[:page])
    @members = Member.where(id: @exams.pluck(:member_id))
    @lessons = Lesson.where(id: @exams.pluck(:lesson_id).uniq)

    render :todo, layout: 'my'
  end

  def show
    @referenced_exam = @exam.referenced_exam
  end

  def edit
  end

  def update
    @exam.assign_attributes(exam_params)
    @exam.reviewer_id = current_member.id

    respond_to do |format|
      if @exam.save
        format.html { redirect_to train_lesson_exams_url(@lesson), notice: 'Exam was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render :edit }
        format.js { head :no_content }
      end
    end
  end

  def score
    @exam.update_score(exam_params)
  end

  def refer
    @exam.set_referenced
    redirect_to train_lesson_paper_exams_url(@lesson.lesson_paper_id), notice: 'Exam was successfully set referenced.'
  end

  def destroy
    @exam.destroy
    redirect_to train_lesson_paper_exams_url(@exam.lesson_paper_id), notice: 'Exam was successfully destroyed.'
  end

  private
  def set_lesson_paper
    @lesson_paper = LessonPaper.find params[:lesson_paper_id]
  end

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.fetch(:exam, {}).permit(
      :lesson_id,
      :answer_mark,
      :comment
    )
  end

end
