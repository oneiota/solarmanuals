class AddPerformanceMultiplierToManuals < ActiveRecord::Migration
  def change
    add_column :manuals, :performance_multiplier, :decimal, :precision => 8, :scale => 2, :default => 0.75
  end
end
