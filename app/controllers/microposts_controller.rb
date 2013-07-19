class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def show
    @user = current_user
    @micropost = Micropost.find(params[:id]) 
    @agreed_feed_items = @micropost.agreed_microposts.paginate(page: params[:page], per_page: 10)
    @agreer_feed_items = @micropost.agreers.paginate(page: params[:page], per_page: 10)
    @new_micropost = current_user.microposts.build
    @new_micropost.agreements.build
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  def agreeing
    @title = "Agreeing"
    @micropost = Micropost.find(params[:id])
    @microposts = @micropost.agreed_microposts.paginate(page: params[:page])
    render 'show_agree'
  end

  def agreers
    @title = "Agreers"
    @micropost = Micropost.find(params[:id])
    @microposts = @micropost.agreers.paginate(page: params[:page])
    render 'show_agree'
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end

end

