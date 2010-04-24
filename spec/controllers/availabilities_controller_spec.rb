require 'spec_helper'

describe AvailabilitiesController do

  def mock_availability(stubs={})
    @mock_availability ||= mock_model(Availability, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all availabilities as @availabilities" do
      Availability.stub(:all) { [mock_availability] }
      get :index
      assigns(:availabilities).should eq([mock_availability])
    end
  end

  describe "GET show" do
    it "assigns the requested availability as @availability" do
      Availability.stub(:find).with("37") { mock_availability }
      get :show, :id => "37"
      assigns(:availability).should be(mock_availability)
    end
  end

  describe "GET new" do
    it "assigns a new availability as @availability" do
      Availability.stub(:new) { mock_availability }
      get :new
      assigns(:availability).should be(mock_availability)
    end
  end

  describe "GET edit" do
    it "assigns the requested availability as @availability" do
      Availability.stub(:find).with("37") { mock_availability }
      get :edit, :id => "37"
      assigns(:availability).should be(mock_availability)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created availability as @availability" do
        Availability.stub(:new).with({'these' => 'params'}) { mock_availability(:save => true) }
        post :create, :availability => {'these' => 'params'}
        assigns(:availability).should be(mock_availability)
      end

      it "redirects to the created availability" do
        Availability.stub(:new) { mock_availability(:save => true) }
        post :create, :availability => {}
        response.should redirect_to(availability_url(mock_availability))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved availability as @availability" do
        Availability.stub(:new).with({'these' => 'params'}) { mock_availability(:save => false) }
        post :create, :availability => {'these' => 'params'}
        assigns(:availability).should be(mock_availability)
      end

      it "re-renders the 'new' template" do
        Availability.stub(:new) { mock_availability(:save => false) }
        post :create, :availability => {}
        response.should render_template(:new)
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested availability" do
        Availability.should_receive(:find).with("37") { mock_availability }
        mock_availability.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :availability => {'these' => 'params'}
      end

      it "assigns the requested availability as @availability" do
        Availability.stub(:find) { mock_availability(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:availability).should be(mock_availability)
      end

      it "redirects to the availability" do
        Availability.stub(:find) { mock_availability(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(availability_url(mock_availability))
      end
    end

    describe "with invalid params" do
      it "assigns the availability as @availability" do
        Availability.stub(:find) { mock_availability(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:availability).should be(mock_availability)
      end

      it "re-renders the 'edit' template" do
        Availability.stub(:find) { mock_availability(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template(:edit)
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested availability" do
      Availability.should_receive(:find).with("37") { mock_availability }
      mock_availability.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the availabilities list" do
      Availability.stub(:find) { mock_availability(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(availabilities_url)
    end
  end

end
