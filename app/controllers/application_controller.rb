class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    user.ensure_session_token
    session[:session_token] = user.session_token
  end

  def require_login
    unless current_user
      flash[:base] = ["You must be logged in to view that"]
      redirect_to new_session_url
    end
  end

  def require_moderator
    unless current_user.id == Sub.find(params[:id]).user_id
      flash[:base] = ["Only the moderator can edit that"]
      redirect_to subs_url
    end
  end

  def require_post_owner
    
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end
end
