class Weight < ActiveRecord::Base
  scope :recent, order("date DESC")

  def weight= new_weight
    self[:weight] = new_weight
    self[:trend] = compute_trend Weight.previous_trend, new_weight
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
    trend_or_nil recent.find { |w| w.date < Date.today }
  end

  def self.latest_trend
    trend_or_nil recent.first
  end

  def self.trend_or_nil weight
    weight.trend unless weight.nil?
  end
end

