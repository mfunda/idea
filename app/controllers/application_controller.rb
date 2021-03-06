class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :login, :role, :avatar]
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :login, :email, :password, :password_confirmation, :role, :avatar, :current_password) }
	end

	def permission_denied
		render :file => "public/401.html", :status => :unauthorized, layout: false
	end

	rescue_from ActiveRecord::RecordNotFound do
		flash[:warning] = 'Resource not found.'
		redirect_back_or root_path
	end

	def redirect_back_or(path)
		redirect_to request.referer || path
	end
end
