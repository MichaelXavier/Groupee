require 'spec_helper'

describe AssignmentsController do

  def mock_assignment(stubs={})
    @mock_assignment ||= mock_model(Assignment, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all assignments as @assignments" do
      Assignment.stub(:all) { [mock_assignment] }
      get :index
      assigns(:assignments).should eq([mock_assignment])
    end
  end

  describe "GET show" do
    it "assigns the requested assignment as @assignment" do
      Assignment.stub(:find).with("37") { mock_assignment }
      get :show, :id => "37"
      assigns(:assignment).should be(mock_assignment)
    end
  end

  describe "GET new" do
    it "assigns a new assignment as @assignment" do
      Assignment.stub(:new) { mock_assignment }
      get :new
      assigns(:assignment).should be(mock_assignment)
    end
  end

  describe "GET edit" do
    it "assigns the requested assignment as @assignment" do
      Assignment.stub(:find).with("37") { mock_assignment }
      get :edit, :id => "37"
      assigns(:assignment).should be(mock_assignment)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created assignment as @assignment" do
        Assignment.stub(:new).with({'these' => 'params'}) { mock_assignment(:save => true) }
        post :create, :assignment => {'these' => 'params'}
        assigns(:assignment).should be(mock_assignment)
      end

      it "redirects to the created assignment" do
        Assignment.stub(:new) { mock_assignment(:save => true) }
        post :create, :assignment => {}
        response.should redirect_to(assignment_url(mock_assignment))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved assignment as @assignment" do
        Assignment.stub(:new).with({'these' => 'params'}) { mock_assignment(:save => false) }
        post :create, :assignment => {'these' => 'params'}
        assigns(:assignment).should be(mock_assignment)
      end

      it "re-renders the 'new' template" do
        Assignment.stub(:new) { mock_assignment(:save => false) }
        post :create, :assignment => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested assignment" do
        Assignment.should_receive(:find).with("37") { mock_assignment }
        mock_assignment.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :assignment => {'these' => 'params'}
      end

      it "assigns the requested assignment as @assignment" do
        Assignment.stub(:find) { mock_assignment(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:assignment).should be(mock_assignment)
      end

      it "redirects to the assignment" do
        Assignment.stub(:find) { mock_assignment(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(assignment_url(mock_assignment))
      end
    end

    describe "with invalid params" do
      it "assigns the assignment as @assignment" do
        Assignment.stub(:find) { mock_assignment(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:assignment).should be(mock_assignment)
      end

      it "re-renders the 'edit' template" do
        Assignment.stub(:find) { mock_assignment(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  #describe "DELETE destroy" do
  #  it "destroys the requested assignment" do
  #    Assignment.should_receive(:find).with("37") { mock_assignment }
  #    mock_assignment.should_receive(:destroy)
  #    delete :destroy, :id => "37"
  #  end

  #  it "redirects to the assignments list" do
  #    Assignment.stub(:find) { mock_assignment(:destroy => true) }
  #    delete :destroy, :id => "1"
  #    response.should redirect_to(assignments_url)
  #  end
  #end

end
