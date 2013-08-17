class API::AppsController < API::ApplicationController
  # GET /api/apps
  def index
    #TODO: write a separate representer for apps collections
    respond_with App.all, represent_items_with: API::AppRepresenter
  end

  # GET /api/apps/1
  def show
    respond_with App.find(params[:id])
  end

  # POST /api/apps
  def create
    respond_with App.create(app_params)
  end

  # PATCH/PUT /api/apps/1
  def update
    respond_with App.update(app_params)
  end

  # DELETE /api/apps/1
  def destroy
    respond_with App.destroy(params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def app_params
    params.require(:app).permit(:name)
  end
end
