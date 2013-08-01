class StaticPagesController < ApplicationController
  def home
    @feed_items = Micropost.paginate(page: params[:page])
  	if signed_in?
      @micropost  = current_user.microposts.build
      #@feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def politics
    @feed_items = Micropost.where("category = ?", "Politics").paginate(page: params[:page])
    if signed_in?
      @micropost  = current_user.microposts.build
      #@feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def business
    @feed_items = Micropost.where("category = ?", "Business").paginate(page: params[:page])
    if signed_in?
      @micropost  = current_user.microposts.build
      #@feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def lifestyle
    @feed_items = Micropost.where("category = ?", "Lifestyle").paginate(page: params[:page])
    if signed_in?
      @micropost  = current_user.microposts.build
      #@feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
