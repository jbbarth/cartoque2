class API::ApplicationController < ::ApplicationController
  # Include ROAR controller additions, among which a responder that
  # automatically extends resource with its representer so that "#to_json"
  # contains representer additions, HAL links, etc.
  include Roar::Rails::ControllerAdditions

  # API controllers should respond only to json requests
  respond_to :json

  # Sets format to 'json' if it's blank in the request
  # The filter is *prepended* so that it's triggered before other filters, which
  # can then rely on the format easily (see CSRF protection below for instance)
  prepend_before_action :set_json_format_if_none
  def set_json_format_if_none
    request.format = 'json' if params[:format].blank?
  end

  # Disable CSRF protection which doesn't make sense for API calls
  # (taken from the rails doc)
  skip_before_action :verify_authenticity_token, if: :json_request?
  def json_request?
    request.format.json?
  end

  # Rescue from not found exceptions with a clean 404
  rescue_from ActiveRecord::RecordNotFound, ActionView::MissingTemplate do
    render json: { message: "Resource or page not found" }, status: :not_found
  end

  # Rescue from errors on missing parameters
  rescue_from ActionController::ParameterMissing do |e|
    render json: { message: "Missing parameter", exception: { name: e.exception.class.name, message: e.message } },
           status: :unprocessable_entity
  end

  # Renders errors as json
  #
  # Returns a 422 error code by default (unprocessable entity, often validation
  # errors), but this can be overriden if the hash provided as argument has a
  # :status key, then it takes its value as a return code.
  def render_error(hash)
    hash[:json] = { message: "An unexpected error occurred" } if hash[:json].blank?
    status = hash[:status] || :unprocessable_entity
    render json: hash[:json], status: status
  end
end
