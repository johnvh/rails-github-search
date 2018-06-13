class ApplicationController < ActionController::Base
  layout 'application'

  helper_method :current_user, :logged_in?

  def current_user
    session[:user]
  end

  def logged_in?
    session[:token].present?
  end
end
