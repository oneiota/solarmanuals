class ImagesController < ApplicationController
  before_filter :authenticate_user!
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to :back, :notice => "Image deleted"
  end
  
  # PUT
  def set_feature
    Image.find_each(&:unfeature)
    @image = Image.find(params[:id])
    @image.feature = true
    @image.save
    redirect_to @image.manual, :notice => "Feature image updated"
  end
  
end