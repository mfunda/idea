class AdminDashboardController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_user_as_admin
	layout 'admin_dashboard'

	protected

		def authenticate_user_as_admin
			permission_denied unless current_user.is_a?(Admin)
		end
end
