class ChangeMaxTempToFloat < ActiveRecord::Migration
  def change
    change_column :thermostats, :max_temperature, :float
  end
end
