class Weight < ActiveRecord::Base
  def weight= new_weight
    self[:weight] = new_weight
    self[:trend] = compute_trend Weight.previous_trend, new_weight
  end

  def trend
    self[:trend] || weight
  end

  def self.today
    Weight.find_or_initialize_by_date Date.today do |w|
      w.trend = latest_trend
    end
  end

  private
  def compute_trend trend, weight
    trend = trend || weight
    trend - ((trend - weight) * 0.1)
  end

  def self.previous_trend
    prev = Weight.order("date desc").find { |w| w.date < Date.today }
    return prev.trend unless prev.nil?
  end

  def self.latest_trend
    latest = Weight.order("date desc").first
    return latest.trend unless latest.nil?
  end
end
