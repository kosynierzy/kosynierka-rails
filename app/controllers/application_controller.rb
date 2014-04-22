class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  helper_method :current_user
  def current_user
    @current_user ||= (session[:user_id] && User.find_by(id: session[:user_id]))
  end

  helper_method :user_signed_in?
  def user_signed_in?
    !!current_user
  end

  def authenticate_user!
    redirect_to sign_in_path unless current_user
  end
end
