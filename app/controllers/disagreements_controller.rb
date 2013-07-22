class DisagreementsController < ApplicationController
  before_filter :signed_in_user

  def create
    @micropost = Micropost.find(params[:disagreement][:disagreed_id])
    @micropost.disagree!(@micropost)
    respond_to do |format|
      #format.html { redirect_to @micropost }
      #format.js
    end
  end

  def destroy
    @micropost = Disagreement.find(params[:id]).disagreed
    current_micropost.undisagree!(@micropost)
    respond_to do |format|
      format.html { redirect_to @micropost }
      format.js
    end
  end
end