class Admins::UsersController < ApplicationController
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
