class PdfsController < ApplicationController
  
  def destroy
    @pdf = Pdf.find(params[:id])
    @pdf.destroy
    render nothing: true
  end
end