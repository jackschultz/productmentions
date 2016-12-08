require "uri"

URI_REGEX = /(dp\/|gp\/product\/)([a-zA-Z0-9]{10})/

def asin_from_uri(uri)
  asins = []
  uri.path.scan(URI_REGEX).each do |match, asin|
    asins.push(asin)
  end
  return asins

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
