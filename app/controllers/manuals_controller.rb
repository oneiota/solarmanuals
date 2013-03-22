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
        
        send_data pdf.render, filename: "#{@manual.client_name.downcase.squish.gsub( /\s/, '_' )}_gridconnect_user_manual.pdf",
          type: "application/pdf",
          disposition: "attachment"
      end
    end
  end
  
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
    @maunal = Manual.find(params[:id])
    
    if @manual[:filled] && !@manual.paid?
      @manual.current_step = "payment"
    end
    
    if params[:step]
      @manual.current_step = params[:step]
    end
    
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
    @manual.panel_strings.build
    
    @manual.current_step = @manual.steps.first
    
    @all_manuals = current_user.manuals.keep_if(&:filled)
  end

  # GET /manuals/1/edit
  def edit
    @manual = Manual.find(params[:id])
    if params[:step]
      @manual.current_step = params[:step]
    end
    
    @manual.panel_strings.build unless @manual.panel_strings.count > 0
    
    @all_manuals = current_user.manuals.keep_if(&:filled)
  end

  # POST /manuals
  # POST /manuals.json
  def create
    @manual = Manual.new(params[:manual])
    @manual.user = current_user
    if @manual.save
      if @manual.filled
        redirect_to @manual, notice: 'Manual was successfully created.'
      else
        flash[:notice] = 'Your manual has been saved and been added to "My Installs".'
        render action: "new"
      end
    else
      @manual.step_back
      render action: "new"
    end
  end

  # PUT /manuals/1
  # PUT /manuals/1.json
  def update
    @manual = Manual.find(params[:id])
    
    if params[:manual]
      # extract user params since we don't want to assign with assign_attributes
      user_params = params[:manual].delete(:user)
    end
    
    if params[:pdf_list]
      params[:manual] ||= { :pdf_ids => [] }
    end
    
    @manual.assign_attributes(params[:manual])
    
    # payment step
    if params[:payment]
      # don't process payment if one exists (when you hit refresh)
      unless @manual.eway_payment
        # new credit card entered
        if user_params && params[:new_card] == '1'
          @manual.user.assign_attributes(user_params)
          @manual.user.validate_card = true
          # can't rely on normal save validating since we don't necessarily want to keep eway_id
          unless @manual.user.valid?
            @manual.current_step = "payment"
            flash[:alert] = "Invalid credit card details."
            render 'edit'
            return
          end
          @manual.user.create_eway_id
       end
      
        @manual.eway_payment = EwayPayment.process_single_payment!(@manual.user)
        
        # forget eway_id
        if params[:new_card] == '1' && @manual.user.remember == '0'
          @manual.user.eway_id = nil
        end
      end
    end
    
    if @manual.valid? && @manual.filled
      @manual.current_step = nil
    end
    
    respond_to do |format|
      if @manual.save
        if @manual.filled
          format.html { redirect_to @manual, notice: 'Manual was successfully updated.' }
          format.json { head :no_content }
          format.js
        else
          format.html { render action: "edit" }
          format.js
        end
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
  
  def set_feature
    @manual = Manual.find(params[:id])
    @manual.feature_image = Image.find(params[:feature_id])
    @manual.save
    respond_to do |format|
      format.js
    end
  end
  
  
  def duplicate
    @to_dup = Manual.find(params[:manual_id])
    @manual = @to_dup.dup
    @manual.assign_attributes({
      :client_name => "",
      :client_address => "",
      :client_suburb => "",
      :client_postcode => "",
      :install_date => Time.now,
      :filled => false,
      :eway_payment => nil,
      :created_at => Time.now,
      :updated_at => Time.now,
      :current_step => 'customer'
    })
    
    @to_dup.panel_strings.each do |ps|
      @manual.panel_strings << ps.dup
    end
    
    @manual.marked = false
    @manual.duplicate = true
    
    if @manual.save
      redirect_to @manual, :notice => "Manual was duplicated. Fill in new customer details and check over the fields to complete."
    else
      redirect_to manuals_path, :alert => @manual.errors.full_messages.join(" ")
    end
  end
    
end
