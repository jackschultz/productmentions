class CreateMentions < ActiveRecord::Migration[5.0]
  def change
    create_table :mentions do |t|
      t.integer :product_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
