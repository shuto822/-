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

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def mypage
    @user = current_user
    @posts = @user.posts
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
    # 関連する投稿とコメントを削除
    @user.posts.destroy_all
    @user.comments.destroy_all
    
    # ユーザーを削除
    @user.destroy
    
    redirect_to root_path, notice: "アカウントを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_correct_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to mypage_path, alert: "不正なアクセスです。"
    end
  end
end
