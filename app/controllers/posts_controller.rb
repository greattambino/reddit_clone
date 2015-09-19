class PostsController < ApplicationController
  before_action :require_login, except: :show
  before_action :require_post_owner
  def new
    @subs = Sub.all
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:base] = ["Post #{@post.title} Created!"]
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:base] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = Sub.all
    # Use include to pre-load
    @post = Post.includes(:subs).find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    # fail
    if @post.update(post_params)
      flash[:base] = ["Sucessfully Updated Post!"]
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:base] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:base] = ["#{@post.title} deleted."]
    redirect_to :back
  end

  private

  def post_params
    post_data = params.require(:post).permit(:title, :url, :content, :sub_ids => [])
    post_data[:user_id] = current_user.id
    post_data[:sub_ids] ||= []
    post_data
  end
end
