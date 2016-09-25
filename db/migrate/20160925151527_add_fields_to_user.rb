class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :start_month, :integer
    add_column :users, :start_day, :integer
  end
end
