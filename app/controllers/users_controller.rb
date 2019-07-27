class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  PER = 15


  def top
  	@user = current_user
    @coordinates = Coordinate.where(user_id: @user)
  end

  def index
  	@users = User.page(params[:page]).per(PER)
  end


  def show
  	@user = User.find(params[:id])
  	@coordinates = Coordinate.where(user_id: @user)

    #チャット機能
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    @user.id == current_user.id
  	if @user.update(user_params)
       flash[:notice] = "編集しました"
  	   redirect_to mypage_path(@user.id)
    else
       render 'users/edit'
    end
  end

  def correct_user
    user = User.find(params[:id])
    if user != current_user
       redirect_to users_path
    end
  end

  #退会機能
  def resign
    @user = User.find(params[:id])
  end

  def resign_confirm
    @user = User.find(params[:id])
    @user.update(resignation: true, resigned_at: Time.current)
    flash[:notice] = "退会しました。"
    redirect_to coordinates_path
  end


  private
  def user_params
  	params.require(:user).permit(:profile_image, :introduction, :kanji_name, :kana_name, :user_name, :sex, :height, :email)
  end

end
