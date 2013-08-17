class API::ApplicationController < ::ApplicationController
  # Sets format to 'json' if it's blank in the request
  before_action :set_json_format_if_none
  def set_json_format_if_none
    request.format = 'json' if params[:format].blank?
  end

  # Rescue from not found exceptions with a clean 404
  rescue_from ActiveRecord::RecordNotFound do
    render json: { message: "Resource or page not found" }, status: :not_found
  end
end
