class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update]
  
  def show # 6.7で追加
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :profile)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
