class API::ContactsController < API::ApplicationController
  # GET /api/contacts
  def index
    respond_with Contact.all
  end

  # GET /api/contacts/1
  def show
    respond_with Contact.find(params[:id])
  end

  # POST /api/contacts
  def create
    contact = Contact.new(contact_params)
    if contact.save
      respond_with contact
    else
      render_error json: { message: "Validation Failed", errors: contact.errors }
    end
  end

  # PATCH/PUT /api/contacts/1
  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      respond_with contact
    else
      render_error json: { message: "Validation Failed", errors: contact.errors }
    end
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
