class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Ensure users are authenticated for any action
  # 1/ custom authentication via token for api requests
  # (devise dropped support for this in 3.1.x series)
  before_filter :authenticate_user_from_token!
  # 2/ standard authentication through devise for webapp
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

  private
  # See: https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
  def authenticate_user_from_token!
    user_token = request.headers["X-Api-Token"].presence
    user = user_token && User.find_by_authentication_token(user_token.to_s)
    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in :user, user, store: false
    end
  end
end
