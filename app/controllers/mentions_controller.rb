class MentionsController < ApplicationController

  def index
    @mentions = Mention.joins(:comment).order("comments.written_at desc").paginate(:page => params[:page])
  end

end
