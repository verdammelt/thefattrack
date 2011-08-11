class Weight < ActiveRecord::Base
  scope :recent, order("date DESC").where("date != ?", Date.today)

  def weight= new_weight
    self[:weight] = new_weight
    self[:trend] = compute_trend Weight.previous_trend(date), new_weight
  end

  def self.today
    find_or_initialize_by_date Date.today do |w|
      w.trend = latest_trend
    end
  end

  def self.update_weight date, weight
    w = find_or_create_by_date date
    w.weight = weight
    w.save

    order("date ASC").where("date > ?", date).each do |w|
      w.weight = w.weight
      w.save
    end
  end

  private
  def compute_trend trend, weight
    trend = trend || weight
    trend - ((trend - weight) * 0.1)
  end

  def self.previous_trend date
    trend_or_nil recent.find { |w| w.date < (date || Date.new) }
  end

  def self.latest_trend
    trend_or_nil recent.first
  end

  def self.trend_or_nil weight
    weight.trend unless weight.nil?
  end
end

