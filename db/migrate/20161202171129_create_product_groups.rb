class CreateProductGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :product_groups do |t|
      t.string :amazon_name
      t.string :name

      t.timestamps
    end
  end
end
