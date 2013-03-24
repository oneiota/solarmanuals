class PdfsController < ApplicationController
  
  def destroy
    @pdf = Pdf.find(params[:id])
    @pdf.destroy
    redirect_to :back
  end
end