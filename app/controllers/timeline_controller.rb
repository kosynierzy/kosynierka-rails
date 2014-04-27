class TimelineController < ApplicationController
  def index
  end

  private

  def entry
    Entry.new
  end
  helper_method :entry

  def entries
    if current_user && current_user.moderator?
      Entry.joins(:user).order('created_at DESC').page(params[:page])
    else
      Entry.joins(:user).legal.order('created_at DESC').page(params[:page])
    end
  end
  helper_method :entries
end
