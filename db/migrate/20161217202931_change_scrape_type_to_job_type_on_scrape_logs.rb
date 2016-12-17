class ChangeScrapeTypeToJobTypeOnScrapeLogs < ActiveRecord::Migration[5.0]
  def change
    rename_column :scrape_logs, :scrape_type, :job_type
  end
end
