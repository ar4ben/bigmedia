class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def access_denied(exception)
    Rails.logger.error "access denied! '#{exception.message}'"
    flash[:warning] = "access denied! '#{exception.message}'"
    redirect_to admin_root_url
  end
end
