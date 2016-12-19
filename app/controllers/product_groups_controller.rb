class ProductGroupsController < ApplicationController

  def index
    if params[:tf] == 'day'
      interval = '1 days'
    elsif params[:tf] == 'week'
      interval = '7 days'
    elsif params[:tf] == 'month'
      interval = '30 days'
    else
      interval = '1 year'
    end
    @product_groups = ProductGroup.joins(:mentions).where("mentions.created_at > current_date - interval '#{interval}'").select('product_groups.*, count(product_id) as "mentions_count"').group("product_groups.id").order("mentions_count desc")
  end

  def show
    @product_group = ProductGroup.find(params[:id])
    @mentions = @product_group.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
  end

end
