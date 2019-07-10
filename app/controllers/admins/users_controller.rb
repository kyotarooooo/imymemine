class Admins::UsersController < ApplicationController

	before_action :admin_login_check


	def top
	end

	def index
		@user = User.all
	end

	def show
		@user = User.find(params[:id])
		@coordinates = Coordinate.all
	end
end
