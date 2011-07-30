module ApplicationHelper
  include WeightGraph

  def round_for_display f
    return f.round(2) unless f.nil?
    nil
  end
end
