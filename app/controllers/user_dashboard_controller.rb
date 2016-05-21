class UserDashboardController < ApplicationController
	before_action :authenticate_user!
	layout 'user_dashboard'

	def index
		@user = current_user
	end
end
