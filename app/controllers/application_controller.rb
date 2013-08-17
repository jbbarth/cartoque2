class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Ensure users are authenticated for any action
  before_filter :authenticate_user!

  # Redirect user to previously requested page after sign in
  # see: https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  def after_sign_in_path_for(resource)
    return stored_location_for(resource) || root_path
  end

  # Renders a 404 when an object is not found or the catch-all route is reached
  # (no RoutingError inside Cartoque, the user should see a 404..)
  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
      format.any(:atom, :xml, :js, :json) { head :not_found }
    end
  end
end
