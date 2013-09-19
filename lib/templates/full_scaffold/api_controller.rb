class API::<%= class_name %>sController < API::ApplicationController
  # GET /api/<%= plural_name %>
  def index
    respond_with <%= class_name %>.all
  end

  # GET /api/<%= plural_name %>/1
  def show
    respond_with <%= class_name %>.find(params[:id])
  end

  # POST /api/<%= plural_name %>
  def create
    <%= singular_name %> = <%= class_name %>.new(<%= singular_name %>_params)
    if <%= singular_name %>.save
      respond_with <%= singular_name %>
    else
      render_error json: { message: "Validation Failed", errors: <%= singular_name %>.errors }
    end
  end

  # PATCH/PUT /api/<%= plural_name %>/1
  def update
    <%= singular_name %> = <%= class_name %>.find(params[:id])
    if <%= singular_name %>.update(<%= singular_name %>_params)
      respond_with <%= singular_name %>
    else
      render_error json: { message: "Validation Failed", errors: <%= singular_name %>.errors }
    end
  end

  # DELETE /api/<%= plural_name %>/1
  def destroy
    respond_with <%= class_name %>.destroy(params[:id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def <%= singular_name %>_params
    params.require(:<%= singular_name %>).permit(:name)
  end
end
