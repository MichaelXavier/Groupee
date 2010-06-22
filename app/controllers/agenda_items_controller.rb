class AgendaItemsController < ApplicationController
  # GET /agenda_items
  # GET /agenda_items.xml
  def index
    @agenda_items = AgendaItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agenda_items }
    end
  end

  # GET /agenda_items/1
  # GET /agenda_items/1.xml
  def show
    @agenda_item = AgendaItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agenda_item }
    end
  end

  # GET /agenda_items/new
  # GET /agenda_items/new.xml
  def new
    @agenda_item = AgendaItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agenda_item }
    end
  end

  # GET /agenda_items/1/edit
  def edit
    @agenda_item = AgendaItem.find(params[:id])
  end

  # POST /agenda_items
  # POST /agenda_items.xml
  def create
    @agenda_item = AgendaItem.new(params[:agenda_item])

    respond_to do |format|
      if @agenda_item.save
        format.html { redirect_to(:back, :notice => 'Agenda item was successfully created.') }
        format.xml  { render :xml => @agenda_item, :status => :created, :location => @agenda_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agenda_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agenda_items/1
  # PUT /agenda_items/1.xml
  def update
    @agenda_item = AgendaItem.find(params[:id])

    respond_to do |format|
      if @agenda_item.update_attributes(params[:agenda_item])
        format.html { redirect_to(@agenda_item, :notice => 'Agenda item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agenda_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agenda_items/1
  # DELETE /agenda_items/1.xml
  def destroy
    @agenda_item = AgendaItem.find(params[:id])
    @agenda_item.destroy

    respond_to do |format|
      format.html { redirect_to(agenda_items_url) }
      format.xml  { head :ok }
    end
  end
end
