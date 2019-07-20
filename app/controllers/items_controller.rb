class ItemsController < ApplicationController
	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)
		@item.user_id = current_user.id
		if @item.save
		   flash[:notice] = "投稿しました。"
		   redirect_to item_path
		else
		   render 'items/new'
		end
	end

	def index
	end

	def show
		@item = Item.find(params[:id])
	end

	private
	def item_params
		params.require(:item).permit(:user_id, :category_id, :coordinate_id, :item_name, :item_image, :size, :brand, :color)
	end
end
