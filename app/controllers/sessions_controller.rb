class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:create]

  def create
    user = Authorize.new(auth_hash[:uid], auth_hash[:info]).call
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
