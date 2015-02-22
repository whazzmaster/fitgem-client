class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:username, :email, :provider, :uid, :oauth_token, :oauth_secret]
    devise_parameter_sanitizer.for(:sign_in) << [:username, :email, :provider, :uid, :oauth_token, :oauth_secret]
  end

  def after_sign_in_path_for(resource_or_scope)
    if request.env['omniauth.origin']
      request.env['omniauth.origin']
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
