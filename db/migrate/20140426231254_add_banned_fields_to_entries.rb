class AddBannedFieldsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :banned_by, :uuid
    add_column :entries, :banned_at, :datetime

    add_index :entries, :banned_by
  end
end
