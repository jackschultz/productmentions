class HomesController < ApplicationController

  def index
    @mentions = Mention.joins(:comment).order("comments.written_at desc").limit(5)
    @product_groups = ProductGroup.joins(:mentions).select('product_groups.*, count(product_id) as "mentions_count"').group("product_groups.id").order("mentions_count desc").limit(5)
    @subsites = Subsite.joins(:mentions).select('subsites.*, count(comment_id) as "mentions_count"').group("subsites.id").order("mentions_count desc").limit(5)
  end

end
