require 'spec_helper'

describe AgendaItemsController do

  def mock_agenda_item(stubs={})
    @mock_agenda_item ||= mock_model(AgendaItem, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all agenda_items as @agenda_items" do
      AgendaItem.stub(:all) { [mock_agenda_item] }
      get :index
      assigns(:agenda_items).should eq([mock_agenda_item])
    end
  end

  describe "GET show" do
    it "assigns the requested agenda_item as @agenda_item" do
      AgendaItem.stub(:find).with("37") { mock_agenda_item }
      get :show, :id => "37"
      assigns(:agenda_item).should be(mock_agenda_item)
    end
  end

  describe "GET new" do
    it "assigns a new agenda_item as @agenda_item" do
      AgendaItem.stub(:new) { mock_agenda_item }
      get :new
      assigns(:agenda_item).should be(mock_agenda_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested agenda_item as @agenda_item" do
      AgendaItem.stub(:find).with("37") { mock_agenda_item }
      get :edit, :id => "37"
      assigns(:agenda_item).should be(mock_agenda_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created agenda_item as @agenda_item" do
        AgendaItem.stub(:new).with({'these' => 'params'}) { mock_agenda_item(:save => true) }
        post :create, :agenda_item => {'these' => 'params'}
        assigns(:agenda_item).should be(mock_agenda_item)
      end

      it "redirects to the created agenda_item" do
        AgendaItem.stub(:new) { mock_agenda_item(:save => true) }
        post :create, :agenda_item => {}
        response.should redirect_to(agenda_item_url(mock_agenda_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved agenda_item as @agenda_item" do
        AgendaItem.stub(:new).with({'these' => 'params'}) { mock_agenda_item(:save => false) }
        post :create, :agenda_item => {'these' => 'params'}
        assigns(:agenda_item).should be(mock_agenda_item)
      end

      it "re-renders the 'new' template" do
        AgendaItem.stub(:new) { mock_agenda_item(:save => false) }
        post :create, :agenda_item => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested agenda_item" do
        AgendaItem.should_receive(:find).with("37") { mock_agenda_item }
        mock_agenda_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :agenda_item => {'these' => 'params'}
      end

      it "assigns the requested agenda_item as @agenda_item" do
        AgendaItem.stub(:find) { mock_agenda_item(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:agenda_item).should be(mock_agenda_item)
      end

      it "redirects to the agenda_item" do
        AgendaItem.stub(:find) { mock_agenda_item(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(agenda_item_url(mock_agenda_item))
      end
    end

    describe "with invalid params" do
      it "assigns the agenda_item as @agenda_item" do
        AgendaItem.stub(:find) { mock_agenda_item(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:agenda_item).should be(mock_agenda_item)
      end

      it "re-renders the 'edit' template" do
        AgendaItem.stub(:find) { mock_agenda_item(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  #describe "DELETE destroy" do
  #  it "destroys the requested agenda_item" do
  #    AgendaItem.should_receive(:find).with("37") { mock_agenda_item }
  #    mock_agenda_item.should_receive(:destroy)
  #    delete :destroy, :id => "37"
  #  end

  #  it "redirects to the agenda_items list" do
  #    AgendaItem.stub(:find) { mock_agenda_item(:destroy => true) }
  #    delete :destroy, :id => "1"
  #    response.should redirect_to(agenda_items_url)
  #  end
  #end

end
