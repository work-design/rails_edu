class Edu::Admin::TeachersController < Edu::Admin::BaseController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit(:name)
    @teachers = Teacher.includes(:member).default_where(q_params).page(params[:page])
  end

  def search
    if params[:q].present?
      @teachers = Teacher.default_where('name-like': params[:q])
    else
      @teachers = Teacher.none
    end

    results = []
    @teachers.each do |teacher|
      results << { name: teacher.name, id: teacher.id }
    end
    render json: { results: results }
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      redirect_to admin_teachers_url, notice: 'Teacher was successfully created.'
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
      redirect_to admin_teachers_url, notice: 'Teacher was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @teacher.destroy
    redirect_to admin_teachers_url, notice: 'Teacher was successfully destroyed.'
  end

  private
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.fetch(:teacher, {}).permit(:name, :description, :user_id, :member_id)
  end

end
