class UsersController < ApplicationController

  before_action :authenticate_user!
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
