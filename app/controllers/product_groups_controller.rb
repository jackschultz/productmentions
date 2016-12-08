class ProductGroupsController < ApplicationController

  def index
    @product_groups = ProductGroup.all
  end

  def show
    @product_group = ProductGroup.find(params[:id])
    @mentions = @product_group.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
  end

end
