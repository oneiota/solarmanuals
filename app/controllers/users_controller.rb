class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    redirect_to root_url
  end
  
end