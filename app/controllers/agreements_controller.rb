class AgreementsController < ApplicationController
  before_filter :signed_in_user

  def create
    @micropost = Micropost.find(params[:agreement][:agreed_id])
    @micropost.agree!(@micropost)
    respond_to do |format|
      #format.html { redirect_to @micropost }
      #format.js
    end
  end

  def destroy
    @micropost = Agreement.find(params[:id]).agreed
    current_micropost.unagree!(@micropost)
    respond_to do |format|
      format.html { redirect_to @micropost }
      format.js
    end
  end
end