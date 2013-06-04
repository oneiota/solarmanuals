class ChecklistItemsController < ApplicationController
  before_filter :authenticate_user!
  # GET /checklist_items
  # GET /checklist_items.json
  def index
    @checklist_items = ChecklistItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checklist_items }
    end
  end

  # GET /checklist_items/1
  # GET /checklist_items/1.json
  def show
    @checklist_item = ChecklistItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checklist_item }
    end
  end

  # GET /checklist_items/new
  # GET /checklist_items/new.json
  def new
    @checklist_item = ChecklistItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checklist_item }
    end
  end

  # GET /checklist_items/1/edit
  def edit
    @checklist_item = ChecklistItem.find(params[:id])
  end

  # POST /checklist_items
  # POST /checklist_items.json
  def create
    @checklist_item = ChecklistItem.new(params[:checklist_item])

    respond_to do |format|
      if @checklist_item.save
        format.html { redirect_to @checklist_item, notice: 'Checklist item was successfully created.' }
        format.json { render json: @checklist_item, status: :created, location: @checklist_item }
      else
        format.html { render action: "new" }
        format.json { render json: @checklist_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checklist_items/1
  # PUT /checklist_items/1.json
  def update
    @checklist_item = ChecklistItem.find(params[:id])

    respond_to do |format|
      if @checklist_item.update_attributes(params[:checklist_item])
        format.html { redirect_to @checklist_item, notice: 'Checklist item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checklist_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklist_items/1
  # DELETE /checklist_items/1.json
  def destroy
    @checklist_item = ChecklistItem.find(params[:id])
    @checklist_item.destroy

    respond_to do |format|
      format.html { redirect_to checklist_items_url }
      format.json { head :no_content }
    end
  end
end
