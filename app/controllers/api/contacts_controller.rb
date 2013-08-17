class API::ContactsController < API::ApplicationController
  # GET /api/contacts
  def index
    #TODO: write a separate representer for contacts collections
    respond_with Contact.all, represent_items_with: API::ContactRepresenter
  end

  # GET /api/contacts/1
  def show
    respond_with Contact.find(params[:id])
  end

  # POST /api/contacts
  def create
    respond_with Contact.create(contact_params)
  end

  # PATCH/PUT /api/contacts/1
  def update
    respond_with Contact.update(contact_params)
  end

  # DELETE /api/contacts/1
  def destroy
    respond_with Contact.destroy(params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:name)
  end
end
