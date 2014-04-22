class AddUserIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :user_id, :uuid
    add_index :entries, :user_id
  end
end
