class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :author, null: false
      t.string :subject, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
