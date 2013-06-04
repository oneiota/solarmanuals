class PdfsController < ApplicationController
  before_filter :authenticate_user!
  def destroy
    @pdf = Pdf.find(params[:id])
    @pdf.destroy
    redirect_to :back
  end
end