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
end
