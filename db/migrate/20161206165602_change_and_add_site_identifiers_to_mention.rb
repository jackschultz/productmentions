class ChangeAndAddSiteIdentifiersToMention < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :site_ident, :site_comment_ident
    add_column :comments, :site_thread_ident, :string
  end
end
