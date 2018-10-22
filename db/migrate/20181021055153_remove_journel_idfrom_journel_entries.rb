class RemoveJournelIdfromJournelEntries < ActiveRecord::Migration[5.1]
  def change
    remove_column :journel_entries, :journel_id, :integer
  end
end
