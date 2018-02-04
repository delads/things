class AddMakerIdToThermostats < ActiveRecord::Migration
  def change
    add_column :makers, :maker_id, :integer
  end
end
