class UsersController < ApplicationController

  before_action :authenticate_user!



  def top
  	@user = current_user
    @coordinates = Coordinate.where(user_id: @user)
  end

  def index
  	@users = User.all
  end


  def show
  	@user = User.find(params[:id])
  	@coordinates = Coordinate.where(user_id: @user)
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
       flash[:notice] = "編集しました"
  	   redirect_to mypage_path(@user.id)
    else
       render 'users/edit'
    end
  end


  private
  def user_params
  	params.require(:user).permit(:profile_image, :introduction, :kanji_name, :kana_name, :user_name, :sex, :height, :email)
  end

end
