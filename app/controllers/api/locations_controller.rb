class API::LocationsController < API::ApplicationController
  # GET /api/locations
  def index
    respond_with Location.all
  end

  # GET /api/locations/1
  def show
    respond_with Location.find(params[:id])
  end

  # POST /api/locations
  def create
    location = Location.new(location_params)
    if location.save
      respond_with location
    else
      render_error json: { message: "Validation Failed", errors: location.errors }
    end
  end

  # PATCH/PUT /api/locations/1
  def update
    location = Location.find(params[:id])
    if location.update(location_params)
      respond_with location
    else
      render_error json: { message: "Validation Failed", errors: location.errors }
    end
  end

  # DELETE /api/locations/1
  def destroy
    respond_with Location.destroy(params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:name)
  end
end
