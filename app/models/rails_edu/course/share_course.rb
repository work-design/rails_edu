module RailsEdu::Course::ShareCourse

  def enabled?
    self.next_finish_time && self.next_finish_time > Time.now
  end

end
