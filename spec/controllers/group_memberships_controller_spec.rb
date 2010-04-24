require 'spec_helper'

describe GroupMembershipsController do

  def mock_group_membership(stubs={})
    @mock_group_membership ||= mock_model(GroupMembership, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all group_memberships as @group_memberships" do
      GroupMembership.stub(:all) { [mock_group_membership] }
      get :index
      assigns(:group_memberships).should eq([mock_group_membership])
    end
  end

  describe "GET show" do
    it "assigns the requested group_membership as @group_membership" do
      GroupMembership.stub(:find).with("37") { mock_group_membership }
      get :show, :id => "37"
      assigns(:group_membership).should be(mock_group_membership)
    end
  end

  describe "GET new" do
    it "assigns a new group_membership as @group_membership" do
      GroupMembership.stub(:new) { mock_group_membership }
      get :new
      assigns(:group_membership).should be(mock_group_membership)
    end
  end

  describe "GET edit" do
    it "assigns the requested group_membership as @group_membership" do
      GroupMembership.stub(:find).with("37") { mock_group_membership }
      get :edit, :id => "37"
      assigns(:group_membership).should be(mock_group_membership)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created group_membership as @group_membership" do
        GroupMembership.stub(:new).with({'these' => 'params'}) { mock_group_membership(:save => true) }
        post :create, :group_membership => {'these' => 'params'}
        assigns(:group_membership).should be(mock_group_membership)
      end

      it "redirects to the created group_membership" do
        GroupMembership.stub(:new) { mock_group_membership(:save => true) }
        post :create, :group_membership => {}
        response.should redirect_to(group_membership_url(mock_group_membership))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved group_membership as @group_membership" do
        GroupMembership.stub(:new).with({'these' => 'params'}) { mock_group_membership(:save => false) }
        post :create, :group_membership => {'these' => 'params'}
        assigns(:group_membership).should be(mock_group_membership)
      end

      it "re-renders the 'new' template" do
        GroupMembership.stub(:new) { mock_group_membership(:save => false) }
        post :create, :group_membership => {}
        response.should render_template(:new)
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested group_membership" do
        GroupMembership.should_receive(:find).with("37") { mock_group_membership }
        mock_group_membership.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :group_membership => {'these' => 'params'}
      end

      it "assigns the requested group_membership as @group_membership" do
        GroupMembership.stub(:find) { mock_group_membership(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:group_membership).should be(mock_group_membership)
      end

      it "redirects to the group_membership" do
        GroupMembership.stub(:find) { mock_group_membership(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(group_membership_url(mock_group_membership))
      end
    end

    describe "with invalid params" do
      it "assigns the group_membership as @group_membership" do
        GroupMembership.stub(:find) { mock_group_membership(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:group_membership).should be(mock_group_membership)
      end

      it "re-renders the 'edit' template" do
        GroupMembership.stub(:find) { mock_group_membership(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template(:edit)
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested group_membership" do
      GroupMembership.should_receive(:find).with("37") { mock_group_membership }
      mock_group_membership.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the group_memberships list" do
      GroupMembership.stub(:find) { mock_group_membership(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(group_memberships_url)
    end
  end

end
