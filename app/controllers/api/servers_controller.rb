class API::ServersController < API::ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  # GET /api/servers
  def index
    #TODO: write a separate representer for servers collections
    respond_with Server.all, represent_items_with: API::ServerRepresenter
  end

  # GET /api/servers/1
  def show
    respond_with Server.find(params[:id])
  end

  # POST /api/servers
  def create
    server = Server.new(server_params)
    if server.save
      respond_with server
    else
      render json: { message: "Validation Failed", errors: server.errors }.to_json
    end
  end

  # PATCH/PUT /api/servers/1
  def update
    server = Server.find(params[:id])
    if server.update(server_params)
      respond_with server
    else
      render json: { message: "Validation Failed", errors: server.errors }.to_json
    end
  end

  # DELETE /api/servers/1
  def destroy
    respond_with Server.destroy(params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def server_params
    params.require(:server).permit(:name)
  end
end
