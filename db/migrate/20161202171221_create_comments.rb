class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :subsite_id
      t.string :url
      t.string :username
      t.string :text
      t.datetime :written_at

      t.timestamps
    end
  end
end
