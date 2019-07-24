class Admins::UsersController < ApplicationController

	before_action :admin_login_check
	PER = 15


	def top
	end

	def index
		@users = User.page(params[:page]).per(PER)
	end

	def show
		@user = User.find(params[:id])
		@coordinates = Coordinate.all
	end
end
