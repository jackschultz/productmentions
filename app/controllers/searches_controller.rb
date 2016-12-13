class SearchesController < ApplicationController

  def index
    if params[:term] && params[:term] != ''
      if params[:group] == 'comments'
        @comments = Comment.search(params[:term]).paginate(:page => params[:page])
      elsif params[:group] == 'products'
        @products = Product.search(params[:term]).paginate(:page => params[:page])
      else
        @comments = Comment.search(params[:term]).limit(5)
        @products = Product.search(params[:term]).limit(5)
      end
    end
  end

end
