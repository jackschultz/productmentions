class ChangeUsernameToAuthor < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :username, :author
  end
end
