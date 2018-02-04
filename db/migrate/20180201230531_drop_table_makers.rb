class DropTableMakers < ActiveRecord::Migration
  def change
    drop_table :makers
  end
end
