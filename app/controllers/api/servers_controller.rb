class API::ServersController < ApplicationController
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
    respond_with Server.create(server_params)
  end

  # PATCH/PUT /api/servers/1
  def update
    respond_with Server.update(server_params)
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
