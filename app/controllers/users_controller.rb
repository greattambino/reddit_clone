class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
    #sign up
  end

  def create
    @user = User.new(user_params)
    @user.ensure_session_token
    # fail
    if @user.save
      login_user!(@user)
      flash[:base] = ["User created!"]
      redirect_to user_url(@user)
    else
      flash.now[:base] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end
end
