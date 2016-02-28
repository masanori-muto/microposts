class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
  def show # 6.7で追加
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # 6.7で追加
    else
      #登録できなかった時
      flash.now[:alert] = "ユーザー登録に失敗しました"
      render 'edit'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end
  
  def followings
    @user  = User.find(params[:id])
    @users = @user.following_users
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.follower_users
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :profile)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if current_user != @user
  end
  
end
