class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :asin
      t.string :title
      t.integer :product_group_id
      t.string :url

      t.timestamps
    end
  end
end
