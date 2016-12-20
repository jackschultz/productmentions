class ProductsController < ApplicationController

  def index
    interval = interval_from_params
    @products = Product.joins(:mentions).where("mentions.created_at > current_date - interval '#{interval}'").select('products.*, count(product_id) as "mentions_count"').group("products.id").order("mentions_count desc").paginate(:page => params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

end
