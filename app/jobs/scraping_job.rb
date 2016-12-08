class ScrapingJob < ActiveJob::Base

  queue_as :default

  BASE_URL = "http://www.reddit.com"

  def perform#(site_id)
    #subsite = Subsite.find(site_id)
    #class_name = "Scrapers::#{subsite.site.name.tr(" ", '')}Scraper".constantize
    #scraper = class_name.new(subsite)
    #scraper = Scrapers::RedditScraper.new
    #scraper.gather_comments
    #scraper.gather_threads_search
    #scraper.gather_threads
  end

end
