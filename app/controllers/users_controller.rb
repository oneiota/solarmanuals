class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  # only for logo (probably)
  def update
    @user = User.find(params[:id])
    unless @user.update_attributes(params[:user])
      flash[:alert] = "Please use an image under 2MB"
    end
    redirect_to root_url
  end
  
end