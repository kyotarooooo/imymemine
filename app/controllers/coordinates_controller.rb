class CoordinatesController < ApplicationController

  before_action :user_login_check, only: [:new, :create, :edit, :update, :show]
  before_action :correct_coordinate, only: [:edit, :update]
  PER = 20


  def index
  	@coordinates = Coordinate.page(params[:page]).per(PER)
    #いいね順に記事をランキングでとってくる
    @all_ranks = Coordinate.find(Like.group(:coordinate_id).order('count(coordinate_id)desc').limit(3).pluck(:coordinate_id))
  end

  def new
  	@coordinate = Coordinate.new
    @item = @coordinate.items.build
  end

  def create
  	@coordinate = Coordinate.new(coordinate_params)
    @coordinate.user = current_user
  	if @coordinate.save
       flash[:notice] = "投稿しました。"
  	   redirect_to coordinate_path(@coordinate.id)
    else
       render 'coordinates/new'
    end
  end

  def show
  	@coordinate = Coordinate.find(params[:id])
    @items = Item.where(coordinate_id: @coordinate.id)
    @like = Like.new
  end

  def edit
  	@coordinate = Coordinate.find(params[:id])
    @item = @coordinate.items.build
  end

  def update
  	@coordinate = Coordinate.find(params[:id])
  	@coordinate.user_id = current_user.id
  	if @coordinate.update(update_coordinate_params)
       flash[:notice] = "編集しました。"
  	   redirect_to coordinate_path(@coordinate.id)
    else
       render 'coordinates/edit'
    end
  end

  def destroy
  	@coordinate = Coordinate.find(params[:id])
  	@coordinate.destroy
  	redirect_to mypage_path(current_user.id)
  end

  def mens_coordinate
    @users = User.where(sex: "男性")
    @coordinates = Coordinate.where(user_id: @users).page(params[:page]).per(PER)
  end

  def ladies_coordinate
    @users = User.where(sex: "女性")
    @coordinates = Coordinate.where(user_id: @users).page(params[:page]).per(PER)
  end

  def search
    @coordinates = Coordinate.search(params[:search]).page(params[:page]).per(PER)
  end


  def correct_coordinate
    coordinate = Coordinate.find(params[:id])
    if coordinate.user_id != current_user.id
      redirect_to coordinates_path
    end
  end

  private
  def coordinate_params
  	params.require(:coordinate).permit(:coordinate_image, :body, items_attributes: [:coordinate_id, :item_image, :item_name, :size, :brand, :color, :category_name])
  end

  def update_coordinate_params
    params.require(:coordinate).permit(:coordinate_image, :body, items_attributes: [:item_image, :item_name, :size, :brand, :color, :category_name, :_destroy, :id])
  end
end

