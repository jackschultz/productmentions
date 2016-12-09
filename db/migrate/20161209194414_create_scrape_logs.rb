class CreateScrapeLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :scrape_logs do |t|
      t.string :scrape_type
      t.datetime :start_time
      t.datetime :end_time
      t.string :start_ident
      t.string :end_ident
      t.integer :mentions_count
      t.integer :comments_count
      t.boolean :error
      t.string :error_message

      t.timestamps
    end
  end
end
