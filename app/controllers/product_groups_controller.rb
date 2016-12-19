class ProductGroupsController < ApplicationController

  def index
    if params[:tf] == 'day'
      @product_groups = ProductGroup.joins(:mentions).where("mentions.created_at > current_date - interval '1 days'").select('product_groups.*, count(product_id) as "mentions_count"').group("product_groups.id").order("mentions_count desc")
    elsif params[:tf] == 'month'
      @product_groups = ProductGroup.joins(:mentions).select('product_groups.*, count(product_id) as "mentions_count"').group("product_groups.id").order("mentions_count desc")
    else
      @product_groups = ProductGroup.joins(:mentions).where("mentions.created_at > current_date - interval '7 days'").select('product_groups.*, count(product_id) as "mentions_count"').group("product_groups.id").order("mentions_count desc")
    end
  end

  def show
    @product_group = ProductGroup.find(params[:id])
    @mentions = @product_group.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
  end

end
