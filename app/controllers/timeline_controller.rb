class TimelineController < ApplicationController
  def index
    @entry = Entry.new
    @entries = Entry.order('created_at DESC').page(params[:page])
  end
end
