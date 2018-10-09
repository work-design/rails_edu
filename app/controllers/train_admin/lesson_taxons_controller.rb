class TrainAdmin::LessonTaxonsController < TrainAdmin::BaseController
  before_action :set_lesson_taxon, only: [:show, :edit, :update, :destroy]

  def index
    @lesson_taxons = LessonTaxon.page(params[:page])
  end

  def new
    @lesson_taxon = LessonTaxon.new
  end

  def create
    @lesson_taxon = LessonTaxon.new(lesson_taxon_params)

    if @lesson_taxon.save
      redirect_to train_lesson_taxons_url, notice: 'Lesson taxon was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson_taxon.update(lesson_taxon_params)
      redirect_to train_lesson_taxons_url, notice: 'Lesson taxon was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @lesson_taxon.destroy
    redirect_to train_lesson_taxons_url, notice: 'Lesson taxon was successfully destroyed.'
  end

  private
  def set_lesson_taxon
    @lesson_taxon = LessonTaxon.find(params[:id])
  end

  def lesson_taxon_params
    params.fetch(:lesson_taxon, {}).permit(:name)
  end

end
