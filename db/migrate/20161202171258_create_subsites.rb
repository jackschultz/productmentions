class CreateSubsites < ActiveRecord::Migration[5.0]
  def change
    create_table :subsites do |t|
      t.integer :site_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
