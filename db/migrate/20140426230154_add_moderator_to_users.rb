class AddModeratorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :moderator, :bool, null: false, default: false
  end
end
