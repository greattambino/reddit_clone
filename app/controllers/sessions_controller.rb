class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      login_user!(@user)
      flash[:base] = ["Welcome back #{@user.user_name}!"]
      redirect_to user_url(@user)
    else
      @user = User.new(user_params)
      flash.now[:base] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.reset_session_token
    session[:session_token] = nil
    flash.now[:base] = ["Logged out #{@user.user_name}"]
    render :new
  end
end
