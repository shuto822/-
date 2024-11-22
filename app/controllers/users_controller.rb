class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to mypage_path, notice: "アカウントを作成しました"
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def mypage
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, notice: "アカウントを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
