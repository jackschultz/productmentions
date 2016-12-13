class ProductGroupsController < ApplicationController

  def index
    @product_groups = ProductGroup.joins(:mentions).select('product_groups.*, count(product_id) as "mentions_count"').group("product_groups.id").order("mentions_count desc")
  end

  def show
    @product_group = ProductGroup.find(params[:id])
    @mentions = @product_group.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
  end

end
