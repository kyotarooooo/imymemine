class CoordinatesController < ApplicationController

  before_action :user_login_check, only: [:new, :create, :edit, :update, :show]



  def index
  	@coordinates = Coordinate.all
  end

  def new
  	@coordinate = Coordinate.new
  end

  def create
  	@coordinate = Coordinate.new(coordinate_params)
  	@coordinate.user_id = current_user.id
  	if @coordinate.save
       flash[:notice] = "投稿しました。"
  	   redirect_to mypage_path(current_user)
    else
       render 'coordinates/new'
    end
  end

  def show
  	@coordinate = Coordinate.find(params[:id])
  end

  def edit
  	@coordinate = Coordinate.find(params[:id])
  end

  def update
  	@coordinate = Coordinate.find(params[:id])
  	@coordinate.user_id = current_user.id
  	if @coordinate.update(coordinate_params)
       flash[:notice] = "編集しました。"
  	   redirect_to coordinate_path(@coordinate.id)
    else
       render 'coordinates/edit'
    end
  end

  def destroy
  	@coordinate = Coordinate.find(params[:id])
  	@coordinate.destroy
  	redirect_to coordinates_path
  end

  def mens_coordinate
    @users = User.where(sex: "男性")
    @coordinates = Coordinate.where(user_id: @users)
  end

  def ladies_coordinate
    @users = User.where(sex: "女性")
    @coordinates = Coordinate.where(user_id: @users)
  end

  private
  def coordinate_params
  	params.require(:coordinate).permit(:coordinate_image, :body)
  end
end
