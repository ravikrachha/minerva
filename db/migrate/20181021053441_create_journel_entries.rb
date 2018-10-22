class CreateJournelEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :journel_entries do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
