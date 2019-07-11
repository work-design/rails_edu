class Edu::Admin::CourseTaxonsController < Edu::Admin::BaseController
  before_action :set_course_taxon, only: [:show, :edit, :update, :destroy]

  def index
    @course_taxons = CourseTaxon.order(id: :asc).page(params[:page])
  end

  def new
    @course_taxon = CourseTaxon.new
  end

  def create
    @course_taxon = CourseTaxon.new(course_taxon_params)
    
    respond_to do |format|
      if @course_taxon.save
        format.html { redirect_to admin_course_taxons_url }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course_taxon.update(course_taxon_params)
      redirect_to admin_course_taxons_url
    else
      render :edit
    end
  end

  def destroy
    @course_taxon.destroy
    redirect_to admin_course_taxons_url
  end

  private
  def set_course_taxon
    @course_taxon = CourseTaxon.find(params[:id])
  end

  def course_taxon_params
    params.fetch(:course_taxon, {}).permit(
      :name
    )
  end

end
