class ProductsController < ApplicationController

  def index
    interval = interval_from_params
    @products = Product.joins(:mentions).where("mentions.created_at > current_date - interval '#{interval}'").select('products.*, count(product_id) as "mentions_count"').group("products.id").order("mentions_count desc").paginate(:page => params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def interval_from_params
    if params[:tf] == 'day'
      interval = '1 days'
    elsif params[:tf] == 'week'
      interval = '1 week'
    elsif params[:tf] == 'month'
      interval = '30 days'
    else
      interval = '1 week'
    end
    return interval
  end

end
