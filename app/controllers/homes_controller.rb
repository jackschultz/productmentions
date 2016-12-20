class HomesController < ApplicationController

  def index
    interval = '1 week'
    @mentions = Mention.joins(:comment).order("comments.written_at desc").limit(20)
    @product_groups = ProductGroup.joins(:mentions).where("mentions.created_at > current_date - interval '#{interval}'").select('product_groups.*, count(product_id) as "mentions_count"').group("product_groups.id").order("mentions_count desc").limit(5)
    @subsites = Subsite.joins(:mentions).where("mentions.created_at > current_date - interval '#{interval}'").select('subsites.*, count(comment_id) as "mentions_count"').group("subsites.id").order("mentions_count desc").limit(5)
  end

end
