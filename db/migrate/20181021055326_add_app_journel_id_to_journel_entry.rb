class AddAppJournelIdToJournelEntry < ActiveRecord::Migration[5.1]
  def change
    add_column :journel_entries, :app_journel_id, :integer, foreign_key: true
  end
end
