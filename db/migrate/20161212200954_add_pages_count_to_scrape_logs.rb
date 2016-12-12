class AddPagesCountToScrapeLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :scrape_logs, :pages_count, :integer
  end
end
