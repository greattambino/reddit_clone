class SubsController < ApplicationController
  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)

    if @sub.save
      flash[:base] = ["Sub #{@sub.title} created!"]
      redirect_to sub_url(@sub)
    else
      flash.now[:base] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      flash[:base] = ["Sub #{@sub.title} Sucessfully Updated!"]
      redirect_to sub_url(@sub)
    else
      flash.now[:base] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    sub_data = params.require(:sub).permit(:title, :description)
    sub_data[:user_id] = current_user.id
    sub_data
  end
end
