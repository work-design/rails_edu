class Edu::Admin::LessonsController < Edu::Admin::BaseController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @lessons = Lesson.page(params[:page])
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html.phone
        format.html { redirect_to admin_lessons_url, notice: 'Lesson was successfully created.' }
        format.js
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @lesson.assign_attributes(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html.phone
        format.html { redirect_to admin_lessons_url, notice: 'Lesson was successfully updated.' }
        format.js { redirect_back fallback_location: admin_lessons_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js
        format.json { render :show }
      end
    end
  end

  def destroy
    @lesson.destroy
    redirect_to admin_lessons_url, notice: 'Lesson was successfully destroyed.'
  end

  private
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.fetch(:lesson, {}).permit(
      :title,
      :videos,
      :documents
    )
  end

end
