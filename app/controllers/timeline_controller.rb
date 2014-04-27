class TimelineController < ApplicationController
  def index
    use_case = ListEntries.new(current_user, params[:page])
    use_case.call do |entries|
      @view = TimelinePage.new(current_user, entries)
    end
  end
end
