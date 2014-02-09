require 'spec_helper'

describe OperatingSystemsController do
  # Fake devise login
  login_user

  # This should return the minimal set of attributes required to create a valid
  # OperatingSystem. As you add validations to OperatingSystem, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OperatingSystemsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all operating_systems as @operating_systems" do
      operating_system = OperatingSystem.create! valid_attributes
      get :index, {}, valid_session
      assigns(:operating_systems).should eq([operating_system])
    end
  end

  describe "GET show" do
    it "assigns the requested operating_system as @operating_system" do
      operating_system = OperatingSystem.create! valid_attributes
      get :show, {id: operating_system.to_param}, valid_session
      assigns(:operating_system).should eq(operating_system)
    end
  end

  describe "GET new" do
    it "assigns a new operating_system as @operating_system" do
      get :new, {}, valid_session
      assigns(:operating_system).should be_a_new(OperatingSystem)
    end
  end

  describe "GET edit" do
    it "assigns the requested operating_system as @operating_system" do
      operating_system = OperatingSystem.create! valid_attributes
      get :edit, {id: operating_system.to_param}, valid_session
      assigns(:operating_system).should eq(operating_system)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new OperatingSystem" do
        expect {
          post :create, {operating_system: valid_attributes}, valid_session
        }.to change(OperatingSystem, :count).by(1)
      end

      it "assigns a newly created operating_system as @operating_system" do
        post :create, {operating_system: valid_attributes}, valid_session
        assigns(:operating_system).should be_a(OperatingSystem)
        assigns(:operating_system).should be_persisted
      end

      it "redirects to the created operating_system" do
        post :create, {operating_system: valid_attributes}, valid_session
        response.should redirect_to(OperatingSystem.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved operating_system as @operating_system" do
        # Trigger the behavior that occurs when invalid params are submitted
        OperatingSystem.any_instance.stub(:save).and_return(false)
        post :create, {operating_system: { "name" => "invalid value" }}, valid_session
        assigns(:operating_system).should be_a_new(OperatingSystem)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        OperatingSystem.any_instance.stub(:save).and_return(false)
        post :create, {operating_system: { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested operating_system" do
        operating_system = OperatingSystem.create! valid_attributes
        # Assuming there are no other operating_systems in the database, this
        # specifies that the OperatingSystem created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        OperatingSystem.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {id: operating_system.to_param, operating_system: { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested operating_system as @operating_system" do
        operating_system = OperatingSystem.create! valid_attributes
        put :update, {id: operating_system.to_param, operating_system: valid_attributes}, valid_session
        assigns(:operating_system).should eq(operating_system)
      end

      it "redirects to the operating_system" do
        operating_system = OperatingSystem.create! valid_attributes
        put :update, {id: operating_system.to_param, operating_system: valid_attributes}, valid_session
        response.should redirect_to(operating_system)
      end
    end

    describe "with invalid params" do
      it "assigns the operating_system as @operating_system" do
        operating_system = OperatingSystem.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OperatingSystem.any_instance.stub(:save).and_return(false)
        put :update, {id: operating_system.to_param, operating_system: { "name" => "invalid value" }}, valid_session
        assigns(:operating_system).should eq(operating_system)
      end

      it "re-renders the 'edit' template" do
        operating_system = OperatingSystem.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OperatingSystem.any_instance.stub(:save).and_return(false)
        put :update, {id: operating_system.to_param, operating_system: { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested operating_system" do
      operating_system = OperatingSystem.create! valid_attributes
      expect {
        delete :destroy, {id: operating_system.to_param}, valid_session
      }.to change(OperatingSystem, :count).by(-1)
    end

    it "redirects to the operating_systems list" do
      operating_system = OperatingSystem.create! valid_attributes
      delete :destroy, {id: operating_system.to_param}, valid_session
      response.should redirect_to(operating_systems_url)
    end
  end
end
