class Admins::CoordinatesController < ApplicationController

  before_action :admin_login_check


	def index
		@coordinates = Coordinate.all
	end

	def show
		@coordinate = Coordinate.find(params[:id])
    @items = Item.where(coordinate_id: @coordinate.id)
	end


	def destroy
  		@coordinate = Coordinate.find(params[:id])
  		@coordinate.destroy
  		redirect_to admins_coordinates_path
  	end

  	private
  	def coordinate_params
  		params.require(:coordinate).permit(:coordinate_image, :body)
  	end
end

