class EntriesController < ApplicationController
  before_action :authenticate_user!

  respond_to :html

  def create
    form = CreateEntryForm.new(entry_params)
    use_case = CreateEntry.new(current_user, form)

    use_case.call do |entry|
      entry.ip_address = request.remote_ip
    end

    redirect_to root_path, notice: t('entry.added')
  rescue ValidationError => error
    redirect_to root_path, alert: error.errors.full_messages.join(', ')
  rescue UnknownFieldError
    render status: 400
  end

  private

  def entry_params
    params.require(:entry).permit(:content)
  end
end
