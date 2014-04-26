class AddIpAddressToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :ip_address, :inet
  end
end
