class Edu::Admin::CourseStudentsController < Edu::Admin::BaseController
  before_action :set_course
  before_action :set_course_student, only: [:show, :edit, :update]

  def index
    q_params = {}
    q_params.merge! params.permit(:id, :state)
    @course_students = @course.course_students.default_where(q_params).page(params[:page])
  end

  def new
    @course_student = CourseStudent.new
  end

  def create
    @course_student = @course.course_students.build(course_student_params)

    if @course_student.save
      redirect_to admin_course_course_crowds_url(@course)
    else
      render :new
    end
  end

  def update
    if @course_student.update(course_student_params)
      redirect_to course_students_url
    else
      render :edit
    end
  end

  def destroy
    @course_student = @course.course_students.find_by(crowd_student_id: params[:crowd_student_id])
    @course_student.destroy

    redirect_to admin_course_course_crowds_url(@course)
  end

  def check
    add_ids = params[:add_ids].split(',')
    if add_ids.present?
      members = Member.where(id: add_ids)
      members.each do |member|
        add = @course.course_students.find_or_initialize_by(member_id: member.id)
        add.save_with_remind
      end
    end

    remove_ids = params[:remove_ids].split(',')
    if remove_ids.present?
      @course.course_students.where(member_id: remove_ids).each do |pl|
        pl.destroy
      end
    end

    redirect_to admin_course_course_students_url(@course)
  end

  def attend
    if params[:add_ids].present?
      adds = CourseStudent.where(id: params[:add_ids].split(','))
      adds.update_all attended: true
    end

    if params[:remove_ids].present?
      removes = CourseStudent.where(id: params[:remove_ids].split(','))
      removes.update_all attended: false
    end

    head :no_content
  end

  def show
    @course_student = CourseStudent.find_by(id: params[:id])
    @eduing_histories = @course_student.eduing_histories.order('id desc')
  end

  def edit
    @title = "Assign Courses"
  end

  def quit
    @course_student = CourseStudent.find params[:id]
    @course_student.trigger_to! state: 'quitted'
    redirect_to admin_course_course_students_url(member_id: @course_student.member_id)
  end

  private
  def set_course
    @course = Course.find params[:course_id]
  end

  def set_course_student
    @course_student = CourseStudent.find(params[:id])
  end

  def course_student_params
    p = params.fetch(:course_student, {}).permit(
      :state
    )
    p.merge! params.permit(:student_type, :student_id, :crowd_student_id, :course_crowd_id)
  end

end
