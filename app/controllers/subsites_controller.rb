class SubsitesController < ApplicationController

  def index
    if params[:tf] == 'month'
      @subsites = Subsite.joins(:mentions).select('subsites.*, count(comment_id) as "mentions_count"').group("subsites.id").order("mentions_count desc")
    else
      @subsites = Subsite.joins(:mentions).where("mentions.created_at > current_date - interval '7 days'").select('subsites.*, count(comment_id) as "mentions_count"').group("subsites.id").order("mentions_count desc")
    end
  end

  def show
    @subsite = Subsite.find(params[:id])
    @mentions = @subsite.mentions.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
  end

end
