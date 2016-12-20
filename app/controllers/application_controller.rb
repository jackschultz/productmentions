class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  private

  def interval_from_params
    if params[:tf] == 'day'
      interval = '1 days'
    elsif params[:tf] == 'week'
      interval = '7 days'
    elsif params[:tf] == 'month'
      interval = '30 days'
    else
      interval = '1 week'
    end
    return interval
  end

end
