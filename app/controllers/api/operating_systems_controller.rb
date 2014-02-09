class API::OperatingSystemsController < API::ApplicationController
  # GET /api/operating_systems
  def index
    respond_with OperatingSystem.page(params[:page]).per_page(items_per_page)
  end

  # GET /api/operating_systems/1
  def show
    respond_with OperatingSystem.find(params[:id])
  end

  # POST /api/operating_systems
  def create
    operating_system = OperatingSystem.new(operating_system_params)
    if operating_system.save
      respond_with operating_system
    else
      render_error json: { message: "Validation Failed", errors: operating_system.errors }
    end
  end

  # PATCH/PUT /api/operating_systems/1
  def update
    operating_system = OperatingSystem.find(params[:id])
    if operating_system.update(operating_system_params)
      respond_with operating_system
    else
      render_error json: { message: "Validation Failed", errors: operating_system.errors }
    end
  end

  # DELETE /api/operating_systems/1
  def destroy
    respond_with OperatingSystem.destroy(params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def operating_system_params
    params.require(:operating_system).permit(:name)
  end
end
