module Round
  def round_for_display f
    return nil if f.nil?
    ((f*100).round)/100.0
  end
end
