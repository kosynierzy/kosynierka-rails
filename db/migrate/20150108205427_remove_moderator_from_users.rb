class RemoveModeratorFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :moderator
  end

  def down
    add_column :users, :moderator, :bool, null: false, default: false
  end
end
