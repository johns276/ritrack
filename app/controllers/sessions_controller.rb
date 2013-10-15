class SessionsController < ApplicationController
  skip_before_action :authorize

  layout 'login'

  def new
  end

  def create
    user = User.find_by(login_name: params[:login_name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to ritrack_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end

  end #create

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end

end
