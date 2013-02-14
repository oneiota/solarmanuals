class ManualsController < ApplicationController
  layout "pdf", :only => [:document]
  
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def document
    @manual = Manual.find(params[:id])
    
    if @manual.user.subscribed?
      @manual.marked = true
      @manual.save
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = DocumentPdf.new({ :page_size => 'A4' }, @manual)
        
        send_data pdf.render, filename: "manual.pdf",
          type: "application/pdf",
          disposition: "inline"
      end
    end
  end
  
  # GET /manuals
  # GET /manuals.json
  def index
    @manuals = current_user.active_manuals

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @manuals }
    end
  end

  # GET /manuals/1
  # GET /manuals/1.json
  def show
    
    @payment = EwayPayment.new
    
    query = {}
    
    if params[:type] == 'system_details_prefill'
      query[:select] = "system_watts, system_pv_current, system_pv_voltage, system_config"
    elsif params[:type] == 'panel_details_prefill'
      query[:select] = "panels_brand, panels_model, panels_number"
    elsif params[:type] == 'inverter_details_prefill'
      query[:select] = "inverter_brand, inverter_model, inverter_output"
    elsif params[:type] == 'warranty_details_prefill'
      query[:select] = "warranty_inverter, warranty_panels_output_performance, warranty_panels_product, warranty_workmanship"
    end
    
    @manual = Manual.find(params[:id], query)  
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @manual }
    end
  end

  # GET /manuals/new
  # GET /manuals/new.json
  def new
    @manual = Manual.new
    @manual.user = current_user
    @manual.contractor_licence_name ||= current_user.company
    @manual.contractor_name ||= current_user.full_name
    @manual.contractor_phone ||= current_user.company_phone
    
    @all_manuals = current_user.manuals.keep_if(&:completed?)
  end

  # GET /manuals/1/edit
  def edit
    @manual = Manual.find(params[:id])
    @manual.contractor_licence_name ||= current_user.company
    @manual.contractor_name ||= current_user.full_name
    @manual.contractor_phone ||= current_user.company_phone
    
    @all_manuals = current_user.manuals.keep_if(&:completed?)
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
        format.js
      else
        puts @manual.errors.messages
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
  
  def set_feature
    @manual = Manual.find(params[:id])
    @manual.feature_image = Image.find(params[:feature_id])
    @manual.save
    respond_to do |format|
      format.js
    end
  end
  
  
  def pay
    
  end
  
  
end
