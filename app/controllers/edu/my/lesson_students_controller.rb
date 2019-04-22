class Edu::My::LessonStudentsController < Edu::My::BaseController
  before_action :set_lesson_student, only: [:show, :edit, :update, :edit_quit, :update_quit, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit('course.course_taxon_id', 'course.type', 'course.title-asc', :state)
    @lesson_students = current_member.lesson_students.includes(:course).default_where(q_params).page(params[:page])
  end

  def new
    @lesson_student = current_member.lesson_students.build
  end

  def create
    if params[:course_id]
      @lesson_student = current_member.lesson_students.build(course_id: params[:course_id])
    else
      @lesson_student = current_member.lesson_students.build(lesson_student_params)
    end

    if @lesson_student.save_with_remind
      redirect_to my_lesson_students_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson_student.update(lesson_student_params)
      redirect_to my_lesson_students_url
    else
      render :edit
    end
  end

  def edit_quit
  end

  def update_quit
    @lesson_student.quit_note = lesson_student_params[:quit_note]
    @lesson_student.trigger_to! state: 'request_quit'
  end

  def destroy
    @lesson_student.destroy
    redirect_to my_lesson_students_url
  end

  private
  def set_lesson_student
    @lesson_student = LessonStudent.find(params[:id])
  end

  def lesson_student_params
    params.fetch(:lesson_student, {}).permit(
      :course_id,
      :quit_note
    )
  end

end
