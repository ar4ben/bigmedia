class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def access_denied(exception)
    Rails.logger.error "access denied! '#{exception.message}'"
    flash[:warning] = "access denied! '#{exception.message}'"
    redirect_to admin_root_url
  end

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found_error', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  def server_error
    respond_to do |format|
      format.html { render template: 'errors/server_error', layout: 'layouts/error', status: 500 }
      format.all  { render nothing: true, status: 500 }
    end
  end
end
