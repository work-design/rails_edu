class Edu::My::TeachersController < Edu::My::BaseController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      redirect_to my_teacher_url, notice: 'Teacher was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to my_teacher_url, notice: 'Teacher was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @teacher.destroy
    redirect_to my_teacher_url, notice: 'Teacher was successfully destroyed.'
  end

  private
  def set_teacher
    @teacher = current_member&.teacher
  end

  def teacher_params
    params.fetch(:teacher, {}).permit(
      :description
    )
  end

end
