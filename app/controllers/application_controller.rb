class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate

  private
  def authenticate
    if !session[:user_id]
      # mms: recommend named route `sign_in_path`, over string
      redirect_to "/sign_in"
    end
  end

  # mms: do you see the benefit of this change?
  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user
end
