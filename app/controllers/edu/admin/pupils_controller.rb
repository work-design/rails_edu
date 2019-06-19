class Edu::Admin::PupilsController < Edu::Admin::BaseController
  before_action :set_pupil, only: [
    :show, :edit, :update,
    :edit_crowd, :update_crowd, :destroy_crowd, :destroy_card,
    :destroy
  ]

  def index
    q_params = {}
    q_params.merge! default_params
    #q_params.merge! member_id: current_member.id if current_member
    q_params.merge! params.permit(:real_name)
    @pupils = Profile.left_joins(:cards).where.not(cards: { id: nil }).default_where(q_params).order(id: :desc).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @pupil.assign_attributes(pupil_params)

    respond_to do |format|
      if @pupil.save
        format.html.phone
        format.html { redirect_to admin_pupils_url }
        format.js { redirect_back fallback_location: admin_pupils_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_pupils_url }
        format.json { render :show }
      end
    end
  end

  def edit_crowd
    q_params = {
      student_type: 'Pupil',
      'id-not': @pupil.crowd_ids
    }
    q_params.merge! default_params
    @crowds = Crowd.default_where(q_params)
  end

  def update_crowd
    @pupil.join_crowd params[:crowd_id]

    redirect_back fallback_location: admin_pupils_url
  end

  def destroy_crowd
    cs = @pupil.crowd_students.find_by(crowd_id: params[:crowd_id])
    cs.destroy if cs
    redirect_back fallback_location: admin_pupils_url
  end

  def destroy_card
    card = @pupil.cards.find(params[:card_id])
    card.student = nil
    card.save
    
    redirect_back fallback_location: admin_pupils_url
  end

  def destroy
    @pupil.destroy
    redirect_to admin_pupils_url
  end

  private
  def set_pupil
    @pupil = Profile.find(params[:id])
  end

  def pupil_params
    params.fetch(:pupil, {}).permit(
      :real_name,
      :gender,
      :note
    )
  end

end
