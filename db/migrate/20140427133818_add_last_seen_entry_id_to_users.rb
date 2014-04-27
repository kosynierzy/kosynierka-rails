class AddLastSeenEntryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_seen_entry_id, :integer
    add_index :users, :last_seen_entry_id
  end
end
