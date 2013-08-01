class MicropostsController < ApplicationController
  #before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy

  def show
    @user = current_user
    @micropost = Micropost.find(params[:id]) 
    @agreed_feed_items = @micropost.agreed_microposts.paginate(page: params[:page], per_page: 3)
    @agreer_feed_items = @micropost.agreers.paginate(page: params[:page], per_page: 3)
    @disagreed_feed_items = @micropost.disagreed_microposts.paginate(page: params[:page], per_page: 3)
    @disagreer_feed_items = @micropost.disagreers.paginate(page: params[:page], per_page: 3)
    if signed_in?
      @new_micropost = current_user.microposts.build
      @new_micropost.agreements.build
      @new_micropost.disagreements.build
    end
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Opinion created!"
      redirect_to :back
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

  def disagreeing
    @title = "Disagreeing"
    @micropost = Micropost.find(params[:id])
    @microposts = @micropost.disagreed_microposts.paginate(page: params[:page])
    render 'show_disagree'
  end

  def disagreers
    @title = "Disagreers"
    @micropost = Micropost.find(params[:id])
    @microposts = @micropost.disagreers.paginate(page: params[:page])
    render 'show_disagree'
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
    end

end

