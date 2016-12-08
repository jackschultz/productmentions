require 'uri'
require 'HTTParty'
require 'JSON'

class Scraper

  BASE_URL = "http://www.reddit.com"

  def gather_threads_from_subsite(subsite)
    url = subsite.url + ".json"
    #get url
    response = HTTParty.get(url, headers: {"User-Agent" => "Book mentions!"})
    result = JSON.parse(response.body)
    result["data"]["children"].each do |thread|
      permalink = thread["data"]["permalink"]
      gather_comments_from_thread(permalink)
    end
  end

  def gather_comments_from_thread(permalink)
    url = BASE_URL + permalink + ".json"
    url = "https://www.reddit.com/r/books/comments/5fs6bc/stiff_the_curious_lives_of_human_cadavers_by_mary/.json"
    response = HTTParty.get(url, headers: {"User-Agent" => "Book mentions!"})
    results = JSON.parse(response.body)
    results.each do |result|
      gather_info_from_listing(results)
    end
  end

  def gather_info_from_data(data)
    if data["kind"] == "Listing"
      gather_info_from_listing(data["data"]["children"])
    elsif data["kind"] == "t1"
      gather_info_from_t1(data["data"])
    elsif data["kind"] == "t3"
      gather_info_from_t3(data["data"])
    end
  end

  def gather_info_from_listing(listing)
    listing["data"]["children"].each do |child|
      self.gather_info_from_data(child)
    end
  end

  def gather_info_from_t3(data)
    text = data["selftext"]
    author = data["author"]
    written_at = data["created"].to_i #in seconds since epoch
    url = data["url"]
    puts text
    puts
  end

  def gather_info_from_t1(data)
    text = data["body"]
    author = data["author"]
    written_at = data["created"].to_i #in seconds since epoch
    url = data["name"] #form of kind_permalinkid
    #find of create comment by permalink
    #set text
    #set author
    #set written_at
    puts text
    puts
    if data["replies"] != ""
      gather_info_from_listing(data["replies"])
    end
  end

  URI_REGEX = /(dp\/|gp\/product\/)([a-zA-Z0-9]{10})/
  def asin_from_uri(uri)
    asins = []
    uri.path.scan(URI_REGEX).each do |match, asin|
      asins.push(asin)
    end
    return asins
  end

  def extract_uris_from_comment_string(string)
    strings.each do |string|
      urls = URI.extract(string, /http(s)?|www./)

      urls.each do |url|
        uri = URI.parse(url)
        if uri.host.include?("amazon")
          puts asin_from_uri(uri)
        end
      end
    end
  end

end
