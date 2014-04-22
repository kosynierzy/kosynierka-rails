class AddContentHtmlToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :content_html, :text
  end
end
