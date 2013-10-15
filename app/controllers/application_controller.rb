class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  before_filter :session_expiry
  MAX_SESSION_PERIOD = 1800

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  def session_expiry
    if session[:expiry_time] and session[:expiry_time] < Time.now
      reset_session
      session[:user_id] = nil
      @current_user = nil
      redirect_to login_url, :notice => "Please log in"
      return false
    else
      session[:expiry_time] = MAX_SESSION_PERIOD.seconds.from_now
      @current_user = User.find(session[:user_id]) if session[:user_id] != nil
      return true
    end
  end

end
