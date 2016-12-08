class SubsitesController < ApplicationController

  def index
    @subsites = Subsite.all
  end

  def show
    @subsite = Subsite.find(params[:id])
    @mentions = @subsite.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
  end

end
