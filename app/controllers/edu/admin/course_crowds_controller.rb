class Edu::Admin::CourseCrowdsController < Edu::Admin::BaseController
  before_action :set_course

  def index
    q_params = default_params.merge! params.fetch(:q, {}).permit(:name, :office_id, :email, :department_id)
    q_params.merge! params.permit(:id, :email, :office_id)
    @course_crowds = @course.course_crowds
    @crowds = Crowd.includes(crowd_students: :student).default_where(q_params).page(params[:page])

    @course_students = @course.course_students.page(params[:page])
  end

  def create
    @course_crowd = @course.course_crowds.build(params.permit(:crowd_id))

    respond_to do |format|
      if @course_crowd.save
        format.html.phone
        format.html { redirect_to admin_course_course_crowds_url(@course), notice: 'Course crowd was successfully created.' }
        format.js { redirect_to admin_course_course_crowds_url(@course) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_to admin_course_course_crowds_url(@course) }
        format.json { render :show }
      end
    end
  end

  def update
    @course_crowd.assign_attributes(course_crowd_params)

    respond_to do |format|
      if @course_crowd.save
        format.html.phone
        format.html { redirect_to admin_course_crowds_url, notice: 'Course crowd was successfully updated.' }
        format.js { redirect_back fallback_location: admin_course_crowds_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_course_crowds_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @course_crowd.destroy
    redirect_to admin_course_crowds_url, notice: 'Course crowd was successfully destroyed.'
  end

  private
  def set_course
    @course = Course.find(params[:course_id])
  end

end
