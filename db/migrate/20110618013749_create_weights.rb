class CreateWeights < ActiveRecord::Migration
  def self.up
    create_table :weights do |t|
      t.date :date
      t.float :weight
      t.float :trend

      t.timestamps
    end
  end

  def self.down
    drop_table :weights
  end
end
