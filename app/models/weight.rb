class Weight < ActiveRecord::Base
  scope :recent, order("date DESC")

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
    previous = recent.find { |w| w.date < Date.today }
    return previous.trend unless previous.nil?
  end

  def self.latest_trend
    latest = recent.first
    return latest.trend unless latest.nil?
  end
end
