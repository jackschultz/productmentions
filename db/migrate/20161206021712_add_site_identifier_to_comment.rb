class AddSiteIdentifierToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :site_ident, :string
  end
end
