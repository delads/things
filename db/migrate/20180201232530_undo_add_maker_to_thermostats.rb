class UndoAddMakerToThermostats < ActiveRecord::Migration
  def change
    remove_column :makers, :maker_id
  end
end
