class CreateWeights < ActiveRecord::Migration
  def self.up
    create_table :weights do |t|
      t.date :date
      t.float :weight
      t.float :trend

      t.timestamps
    end

    add_index :weights, [:date], {:name => :unique_date, :unique => true}
  end

  def self.down
    remove_index :weights, :unique_date
    drop_table :weights
  end
end
