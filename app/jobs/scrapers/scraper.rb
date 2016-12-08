require 'uri'
require 'HTTParty'
require 'JSON'
require 'asin'

module Scrapers
  class Scraper

    def initialize#(subsite)
      #@subsite = subsite
    end

    def gather_threads
      #need to implement
      return false
    end

    def find_or_create_product_group(product_group_string)
      pg = ProductGroup.find_or_initialize_by(amazon_name: product_group_string)
      if pg.new_record?
        pg.name = product_group_string
        pg.save
      end
      return pg
    end

    def get_product_from_amazon_api(asin)
      client = ASIN::Client.instance
      items = client.lookup(asin)
      return items.first
    end

    def create_mentions(asins, attrs)#text, author, written_at, url)
      Mention.transaction do
        subsite = find_or_create_subsite(attrs[:url])
        site_comment_ident = attrs[:site_comment_ident]
        comment = subsite.comments.find_or_create_by(site_comment_ident: site_comment_ident)
        comment.update_attributes(attrs)
        asins.each do |asin|
          #=> Mention(id: integer, product_id: integer, comment_id: integer, created_at: datetime, updated_at: datetime)
          #=> Product(id: integer, asin: string, title: string, product_group_id: integer, url: string, created_at: datetime, updated_at: datetime)
          product = Product.find_or_initialize_by(asin: asin)
          if product.new_record?
            item = get_product_from_amazon_api(asin)
            title = item.item_attributes.title
            #hit amazon api to get product info
            product_group_string = item.item_attributes.product_group
            #image_url = item.image_sets.image_set.first["MediumImage"]["URL"]
            url = "https://www.amazon.com/dp/#{asin}/?tag=pmentions-20"
            product.title = title
            product.url = url
            product.product_group = find_or_create_product_group(product_group_string)
            product.save
          end
          product.mentions.find_or_create_by(comment: comment)
        end
      end
    end

    URI_REGEX = /(dp\/|gp\/product\/|gp\/offer\-listing\/)([a-zA-Z0-9]{10})/
    def extract_mentions_from_text(attrs)
      text = attrs[:text]
      asins = []
      puts text
      text.scan(URI_REGEX).each do |match, asin|
        asins.push(asin)
      end
      puts asins
      if asins.any?
        create_mentions(asins, attrs)
      end
      return true
    end

  end
end
