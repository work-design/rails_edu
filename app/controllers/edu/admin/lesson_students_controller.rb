class Edu::Admin::LessonStudentsController < Edu::Admin::BaseController
  before_action :set_lesson
  before_action :set_lesson_student, only: [:show, :edit, :update]

  def index
    @course_students = @lesson.course.course_students.page(params[:page])
    @lesson_students = LessonStudent.page(params[:page])
  end

  def new
    @lesson_student = LessonStudent.new
  end

  def create
    @lesson_student = @lesson.lesson_students.build(course_student_id: params[:course_student_id])

    respond_to do |format|
      if @lesson_student.save
        format.html.phone
        format.html { redirect_to admin_lesson_lesson_students_url(@lesson), notice: 'Lesson student was successfully created.' }
        format.js { redirect_to admin_lesson_lesson_students_url(@lesson) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_lesson_students_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @lesson_student.assign_attributes(lesson_student_params)

    respond_to do |format|
      if @lesson_student.save
        format.html.phone
        format.html { redirect_to admin_lesson_students_url, notice: 'Lesson student was successfully updated.' }
        format.js { redirect_back fallback_location: admin_lesson_students_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_lesson_students_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @lesson_student = @lesson.lesson_students.find_by(course_student_id: params[:course_student_id])
    @lesson_student.destroy
    respond_to do |format|
      format.html { redirect_to admin_lesson_lesson_students_url(@lesson) }
      format.json { render :show }
    end
  end

  private
  def set_lesson
    @lesson = Lesson.find params[:lesson_id]
  end

  def set_lesson_student
    @lesson_student = LessonStudent.find(params[:id])
  end

  def lesson_student_params
    params.fetch(:lesson_student, {}).permit(
      :student,
      :state,
      :attended,
      :created_at
    )
  end

end
