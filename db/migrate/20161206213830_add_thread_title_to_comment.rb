class AddThreadTitleToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :thread_title, :string
  end
end
