class EntriesController < ApplicationController
  before_action :authenticate_user!

  respond_to :html

  def create
    @entry = current_user.entries.new(entry_params)
    @entry.save

    respond_with(@entry) do |format|
      format.html { redirect_to root_path }
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:content)
  end
end
