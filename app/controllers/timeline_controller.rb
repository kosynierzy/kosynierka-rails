class TimelineController < ApplicationController
  def index
    @entry = Entry.new
    @entries = Entry.joins(:user).order('created_at DESC').page(params[:page])
  end
end
