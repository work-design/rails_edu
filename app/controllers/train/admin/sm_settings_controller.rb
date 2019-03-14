class Admin::SmSettingsController < Admin::BaseController
  before_action :set_sm_setting, only: [:show, :edit, :update, :destroy]

  def index
    @sm_settings = SmSetting.page(params[:page])
  end

  def new
    @sm_setting = SmSetting.new
  end

  def create
    @sm_setting = SmSetting.new(sm_setting_params)

    if @sm_setting.save
      redirect_to admin_sm_settings_url, notice: 'Sm setting was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @sm_setting.update(sm_setting_params)
      redirect_to admin_sm_settings_url, notice: 'Sm setting was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @sm_setting.destroy
    redirect_to admin_sm_settings_url, notice: 'Sm setting was successfully destroyed.'
  end

  private
  def set_sm_setting
    @sm_setting = SmSetting.find(params[:id])
  end

  def sm_setting_params
    params.fetch(:sm_setting, {}).permit(
      :access_token,
      :limit_at,
      :working
    )
  end

end