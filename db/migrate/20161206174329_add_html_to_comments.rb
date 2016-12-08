class AddHtmlToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :html, :string
  end
end
