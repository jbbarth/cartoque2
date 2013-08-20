class API::ServersController < API::ApplicationController
  # GET /api/servers
  def index
    respond_with Server.all
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
      render_error json: { message: "Validation Failed", errors: server.errors }
    end
  end

  # PATCH/PUT /api/servers/1
  def update
    server = Server.find(params[:id])
    if server.update(server_params)
      respond_with server
    else
      render_error json: { message: "Validation Failed", errors: server.errors }
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
