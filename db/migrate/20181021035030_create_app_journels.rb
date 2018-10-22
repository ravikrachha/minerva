class CreateAppJournels < ActiveRecord::Migration[5.1]
  def change
    create_table :app_journels do |t|
      t.string :name

      t.timestamps
    end
  end
end
