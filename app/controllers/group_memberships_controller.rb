class GroupMembershipsController < ApplicationController
  # GET /group_memberships
  # GET /group_memberships.xml
  def index
    @group_memberships = GroupMembership.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @group_memberships }
    end
  end

  # GET /group_memberships/1
  # GET /group_memberships/1.xml
  def show
    @group_membership = GroupMembership.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group_membership }
    end
  end

  # GET /group_memberships/new
  # GET /group_memberships/new.xml
  def new
    @group_membership = GroupMembership.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group_membership }
    end
  end

  # GET /group_memberships/1/edit
  def edit
    @group_membership = GroupMembership.find(params[:id])
  end

  # POST /group_memberships
  # POST /group_memberships.xml
  def create
    @group_membership = GroupMembership.new(params[:group_membership])

    respond_to do |format|
      if @group_membership.save
        format.html { redirect_to(@group_membership, :notice => 'Group membership was successfully created.') }
        format.xml  { render :xml => @group_membership, :status => :created, :location => @group_membership }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group_membership.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group_memberships/1
  # PUT /group_memberships/1.xml
  def update
    @group_membership = GroupMembership.find(params[:id])

    respond_to do |format|
      if @group_membership.update_attributes(params[:group_membership])
        format.html { redirect_to(@group_membership, :notice => 'Group membership was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group_membership.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_memberships/1
  # DELETE /group_memberships/1.xml
  def destroy
    @group_membership = GroupMembership.find(params[:id])
    @group_membership.destroy

    respond_to do |format|
      format.html { redirect_to(group_memberships_url) }
      format.xml  { head :ok }
    end
  end
end
