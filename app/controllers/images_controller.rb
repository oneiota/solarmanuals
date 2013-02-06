class ImagesController < ApplicationController
  
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render nothing: true
  end
  
  # PUT
  def set_feature
    Image.find_each(&:unfeature)
    @image = Image.find(params[:id])
    @image.feature = true
    @image.save
  end
  
end