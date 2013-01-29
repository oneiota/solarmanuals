class ManualsController < ApplicationController
  layout "pdf", :only => [:document, :cover]
  
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def document
    @manual = Manual.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = DocumentPdf.new @manual
        send_data pdf.render, filename: "manual.pdf",
          type: "application/pdf",
          disposition: "inline"
      end
    end
  end
  
  # GET /manuals
  # GET /manuals.json
  def index
    @manuals = Manual.not_trashed

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @manuals }
    end
  end

  # GET /manuals/1
  # GET /manuals/1.json
  def show
    @manual = Manual.find(params[:id])
    
    # # check for existing payment
    # if p = @manual.payment
    #   p.setup!(
    #     success_payments_url,
    #     cancel_payments_url
    #   )
    #   @existing_uri = p.redirect_uri
    # else    
    #   @payment = Payment.new
    # end
    
    @payment = @manual.payment || Payment.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @manual }
    end
  end

  # GET /manuals/new
  # GET /manuals/new.json
  def new
    @manual = Manual.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @manual }
    end
  end

  # GET /manuals/1/edit
  def edit
    @manual = Manual.find(params[:id])
  end

  # POST /manuals
  # POST /manuals.json
  def create
    @manual = Manual.new(params[:manual])
    @manual.user = current_user
    respond_to do |format|
      if @manual.save
        format.html { redirect_to @manual, notice: 'Manual was successfully created.' }
        format.json { render json: @manual, status: :created, location: @manual }
      else
        format.html { render action: "new" }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /manuals/1
  # PUT /manuals/1.json
  def update
    @manual = Manual.find(params[:id])

    respond_to do |format|
      if @manual.update_attributes(params[:manual])
        format.html { redirect_to @manual, notice: 'Manual was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @manual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manuals/1
  # DELETE /manuals/1.json
  def destroy
    @manual = Manual.find(params[:id])
    @manual.trashed = true
    @manual.save
    puts @manual.errors.inspect
    respond_to do |format|    
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end
