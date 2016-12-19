class SubsitesController < ApplicationController

  def index
    interval = interval_from_params
    @subsites = Subsite.joins(mentions: :comment).where("comments.written_at > current_date - interval '#{interval}'").select('subsites.*, count(comment_id) as "mentions_count"').group("subsites.id").order("mentions_count desc")
  end

  def show
    interval = interval_from_params
    @subsite = Subsite.find(params[:id])
    if params[:sort] == 'recency'
      @products = Product.joins(mentions: :comment).where("comments.subsite_id = ?", @subsite.id).group("products.id, comments.written_at").order("comments.written_at desc")
    elsif params[:sort] == 'frequency'
      @products = Product.joins(mentions: :comment).select('products.*, count(product_id) as "mentions_count"').group("products.id").where("comments.subsite_id = ?", @subsite.id).order("mentions_count desc")
    else #default to recency
      @products = Product.joins(mentions: :comment).where("comments.subsite_id = ?", @subsite.id).group("products.id, comments.written_at").order("comments.written_at desc")
    end
    @products = @products.where("comments.written_at > current_date - interval '#{interval}'")
    @products = @products.paginate(:page => params[:page])
  end

  private

  def interval_from_params
    if params[:tf] == 'day'
      interval = '1 days'
    elsif params[:tf] == 'week'
      interval = '7 days'
    elsif params[:tf] == 'month'
      interval = '30 days'
    else
      interval = '1 year'
    end
    return interval
  end
end
