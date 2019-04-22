class Edu::Admin::CoursePapersController < Edu::Admin::BaseController
  before_action :set_course
  before_action :set_course_paper, only: [:show, :edit, :update, :add, :destroy]

  def index
    q_params = {
      course_id: params[:course_id]
    }.with_indifferent_access
    q_params.merge! params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:type)
    @course_papers = CoursePaper.default_where(q_params).page(params[:page])
  end

  def new
    @course_paper = CoursePaper.new(type: params[:type], course_id: params[:course_id])
  end

  def create
    @course_paper = CoursePaper.new(course_id: params[:course_id])
    @course_paper.assign_attributes course_paper_params

    if @course_paper.save
      redirect_to admin_course_papers_url(course_id: @course_paper.course_id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course_paper.update(course_paper_params)
      redirect_to admin_course_papers_url(course_id: @course_paper.course_id)
    else
      render :edit
    end
  end

  def add
    @course_paper.add

    redirect_to admin_course_papers_url(course_id: @course_paper.course_id)
  end

  def destroy
    @course_paper.destroy
    redirect_to admin_course_papers_url(course_id: @course_paper.course_id)
  end

  private
  def set_course
    if params[:course_id]
      @course = Course.find params[:course_id]
    end
  end

  def set_course_paper
    @course_paper = CoursePaper.find(params[:id])
  end

  def course_paper_params
    params.fetch(:course_paper, {}).permit(
      :title,
      :description,
      :link,
      :document,
      :type,
      :course_id
    )
  end

end
