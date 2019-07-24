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

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(users_params)
			flash[:notice] = "更新しました。"
			redirect_to admins_user_path(@user)
		else
			render 'admins/edit'
		end
	end

	private
	def users_params
		params.require(:user).permit(:user_id, :profile_image, :introduction, :kanji_name, :kana_name, :user_name, :sex, :height, :email)
  	end
end
