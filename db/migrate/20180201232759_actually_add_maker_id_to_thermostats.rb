class ActuallyAddMakerIdToThermostats < ActiveRecord::Migration
  def change
    add_column :thermostats, :maker_id, :integer
  end
end
