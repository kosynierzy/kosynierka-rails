class RemoveAuthorAndSubjectFromEntries < ActiveRecord::Migration
  def up
    remove_column :entries, :author
    remove_column :entries, :subject
  end

  def down
    add_column :entries, :author, :string, null: false
    add_column :entries, :subject, :string, null: false
  end
end
