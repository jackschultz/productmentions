require 'uri'
require 'HTTParty'
require 'JSON'
require 'asin'

module Scrapers
  class HackerNewsScraper < Scraper

    def gather_threads
      url = @subsite.url
      #get url
      response = HTTParty.get(url, headers: {"User-Agent" => "Product mentions"})
      result = Nokogiri::HTML(response.body)
      #td class subtext last a
      bottoms = result.css("td[class=subtext]")
      threads = []
      bottoms.each do |bottom|
        link = bottom.css("a").last["href"]
        turl = url + link
        threads.push(turl)
        puts turl
      end
      threads.each do |thread_url|
        gather_comments_from_thread(thread_url)
      end
      return true
    end

    def gather_comments_from_thread(thread_url)
      response = HTTParty.get(thread_url, headers: {"User-Agent" => "Book mentions!"})
      result = Nokogiri::HTML(response.body)
      comments = result.css("div[class=comment]")
      comments.each do |comment|
        text = comment.css("span").xpath("text()").to_s.squish
        attrs = {text: text, author: nil, written_at: nil, url: thread_url}
        extract_mentions_from_text(attrs)
      end
    end

  end
end
