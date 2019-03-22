class Edu::My::CourseStudentsController < Edu::My::BaseController
  before_action :set_course_student, only: [:show, :edit, :update, :edit_quit, :update_quit, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit('course.course_taxon_id', 'course.type', 'course.title-asc', :state)
    @course_students = current_member.course_students.includes(:course).default_where(q_params).page(params[:page])
  end

  def new
    @course_student = current_member.course_students.build
  end

  def create
    if params[:course_id]
      @course_student = current_member.course_students.build(course_id: params[:course_id])
    else
      @course_student = current_member.course_students.build(course_student_params)
    end

    if @course_student.save_with_remind
      redirect_to my_course_students_url, notice: 'Course member was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course_student.update(course_student_params)
      redirect_to my_course_students_url, notice: 'Course member was successfully updated.'
    else
      render :edit
    end
  end

  def edit_quit
  end

  def update_quit
    @course_student.quit_note = course_student_params[:quit_note]
    @course_student.trigger_to! state: 'request_quit'
  end

  def destroy
    @course_student.destroy
    redirect_to my_course_students_url, notice: 'Course member was successfully destroyed.'
  end

  private
  def set_course_student
    @course_student = CourseStudent.find(params[:id])
  end

  def course_student_params
    params.fetch(:course_student, {}).permit(:course_id, :quit_note)
  end

end
