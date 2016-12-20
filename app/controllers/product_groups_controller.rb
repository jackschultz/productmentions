class ProductGroupsController < ApplicationController

  def index
    interval = interval_from_params
    @product_groups = ProductGroup.joins(:mentions).where("mentions.created_at > current_date - interval '#{interval}'").select('product_groups.*, count(product_id) as "mentions_count"').group("product_groups.id").order("mentions_count desc")
  end

  def show
    @product_group = ProductGroup.find(params[:id])
    @interval = interval_from_params
    if params[:sort] == 'recency'
      @mentions = @product_group.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
    elsif params[:sort] == 'frequency'
      @products = Product.joins(mentions: :comment).select('products.*, count(mentions.product_id) as "mentions_count"').group("products.id").where(product_group: @product_group).order("mentions_count desc")
      @products = @products.where("comments.written_at > current_date - interval '#{@interval}'")
      @products = @products.paginate(:page => params[:page])
    else #default to recency
      @mentions = @product_group.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
    end
  end

end
