class SubsitesController < ApplicationController

  def index
    @subsites = Subsite.joins(:mentions).select('subsites.*, count(comment_id) as "mentions_count"').group("subsites.id").order("mentions_count desc")
  end

  def show
    @subsite = Subsite.find(params[:id])
    @mentions = @subsite.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
  end

end
