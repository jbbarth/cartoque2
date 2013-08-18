class API::AppsController < API::ApplicationController
  # GET /api/apps
  def index
    respond_with App.all
  end

  # GET /api/apps/1
  def show
    respond_with App.find(params[:id])
  end

  # POST /api/apps
  def create
    app = App.new(app_params)
    if app.save
      respond_with app
    else
      render json: { message: "Validation Failed", errors: app.errors }.to_json
    end
  end

  # PATCH/PUT /api/apps/1
  def update
    app = App.find(params[:id])
    if app.update(app_params)
      respond_with app
    else
      render json: { message: "Validation Failed", errors: app.errors }.to_json
    end
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
