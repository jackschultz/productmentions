require 'uri'
require 'HTTParty'
require 'JSON'
require 'asin'

module Scrapers
  class RedditScraper < Scraper

    BASE_URL = "http://www.reddit.com"
    COMMENT_URL = "https://www.reddit.com/comments/?limit=100"
    THREAD_SEARCH_URL = "https://www.reddit.com/search?q=amazon.com&sort=new&t=hour&limit=100"

    SUBREDDIT_MATCHER = /https:\/\/www.reddit.com\/r\/[a-zA-Z0-9_-]*\//
    def find_or_create_subsite(url)
      #=> Subsite(id: integer, site_id: integer, name: string, url: string, created_at: datetime, updated_at: datetime)
      reddit = Site.where(name: "Reddit").first
      subreddit_url = url.match(SUBREDDIT_MATCHER).to_s
      subsite = reddit.subsites.find_or_initialize_by(url: subreddit_url)
      if subsite.new_record?
        name = subreddit_url.split("/").last
        subsite.name = name
        subsite.save
      end
      subsite.save
      return subsite
    end

    THREAD_SITE_IDENT_MATCHER = /(https:\/\/www.reddit.com\/r\/)([a-zA-Z0-9_-]*)\/(comments)\/([a-zA-Z0-9]{6})/
    def find_site_thread_ident(url)
      arr = url.match(THREAD_SITE_IDENT_MATCHER).to_a
      return arr.last #thread id
    end

    COMMENT_SITE_IDENT_MATCHER = /(https:\/\/www.reddit.com\/r\/)([a-zA-Z0-9_-]*)\/(comments)\/([a-zA-Z0-9]{6})\/([a-zA-Z0-9_-]*)\/([a-zA-Z0-9]{7})/
    def find_site_comment_ident(url)
      arr = url.match(COMMENT_SITE_IDENT_MATCHER).to_a
      return arr.last #comment id
    end

    def gather_comments
      query = {"limit" => 100}
      response = HTTParty.get(COMMENT_URL, headers: {"User-Agent" => "Product Mentions"})#, "query" => query)
      result = Nokogiri::HTML(response.body)
      comments = result.css("div.thing.comment")
      puts comments.length
      id = nil
      comments.each do |comment|
        id = comment["data-fullname"] #for use at the end
        ctext = comment.css("div.usertext-body")
        text = ctext.css("p").xpath("text()").to_s.squish
        author = comment.css("a.author").text
        permalink = comment.css("li.first a").first["href"]
        site_thread_ident = find_site_thread_ident(permalink)
        site_comment_ident = find_site_comment_ident(permalink)
        written_at_string = comment.css("time").first["title"]
        written_at = DateTime.strptime(written_at_string, "%a %b %e %k:%M:%S %Y")
        attrs = {text: text, author: author, written_at: written_at, url: permalink, site_thread_ident: site_thread_ident, site_comment_ident: site_comment_ident}
        extract_mentions_from_text(attrs)
      end
      if id
        query = {"length" => 100, "after" => id}
        #continue to next page
      end
      return comments.length
    end

    def gather_threads_search
      response = HTTParty.get(THREAD_SEARCH_URL, headers: {"User-Agent" => "Product Mentions"})#, "query" => query)
      result = Nokogiri::HTML(response.body)
      posts = result.css("div.search-result-link")
      puts posts.length
      threads = []
      posts.each do |post|
        permalink = post.css("header a").first["href"].split("?")[0]
        threads.push(permalink)
        puts permalink
      end
      threads.each do |thread|
        gather_post_from_url(thread)
      end
      return threads.length
    end

    def gather_threads
      url = @subsite.url + ".json"
      #get url
      response = HTTParty.get(url, headers: {"User-Agent" => "Book mentions!"})
      result = JSON.parse(response.body)
      result["data"]["children"].each do |thread|
        permalink = thread["data"]["permalink"]
        gather_comments_from_thread(permalink)
      end
      return true
    end

    def gather_post_from_url(url)
      url = url + ".json"
      puts url
      response = HTTParty.get(url, headers: {"User-Agent" => "Product Mentions"})
      result = JSON.parse(response.body)
      gather_info_from_data(result.first) #this is the post
    end

    def gather_comments_from_thread(permalink)
      url = BASE_URL + permalink + "?limit=100" + ".json"
      #url = "https://www.reddit.com/r/books/comments/5fs6bc/stiff_the_curious_lives_of_human_cadavers_by_mary/.json"
      response = HTTParty.get(url, headers: {"User-Agent" => "Book mentions!"})
      results = JSON.parse(response.body)
      results.each do |result|
        gather_info_from_data(result)
      end
    end

    def gather_info_from_data(data)
      if data["kind"] == "Listing"
        gather_info_from_listing(data)
      elsif data["kind"] == "t1"
        gather_info_from_t1(data["data"])
      elsif data["kind"] == "t3"
        gather_info_from_t3(data["data"])
      end
    end

    def gather_info_from_listing(listing)
      listing["data"]["children"].each do |child|
        gather_info_from_data(child)
      end
    end

    def gather_info_from_t3(data)
      text = data["selftext"]
      html = data["selftext_html"]
      author = data["author"]
      written_at = DateTime.strptime(data["created"].to_s,'%s')
      url = data["url"]
      title = data["title"]
      site_thread_ident = find_site_thread_ident(url)
      attrs = {text: text, html: html, author: author, written_at: written_at, url: url, thread_title: title, site_thread_ident: site_thread_ident}
      extract_mentions_from_text(attrs)
    end

    def gather_info_from_t1(data)
      text = data["body"]
      html = data["body_html"]
      author = data["author"]
      written_at = DateTime.strptime(data["created"].to_s,'%s')
      url = data["name"] #form of kind_permalinkid
      site_thread_ident = find_site_thread_ident(url)
      site_comment_ident = find_site_comment_ident(url)
      attrs = {text: text, html: html, author: author, written_at: written_at, url: url, site_thread_ident: site_thread_ident, site_comment_ident: site_comment_ident}
      extract_mentions_from_text(attrs)
      if data["replies"] != ""
        gather_info_from_listing(data["replies"])
      end
    end

  end
end
