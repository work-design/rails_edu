class TrainAdmin::BaseController < HrAdmin::BaseController


  def current_teacher
    current_member&.teacher
  end

end
