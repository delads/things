class AddNameToThermostats < ActiveRecord::Migration
  def change
    add_column :thermostats, :name, :string
  end
end
