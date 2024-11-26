class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # 投稿作成成功後に詳細ページへリダイレクト
      redirect_to post_path(@post), notice: "投稿を作成しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @posts = @posts.where("title LIKE ?", "%#{params[:keyword]}%") if params[:keyword].present?
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
    # 投稿者以外が編集できないようにチェック
    redirect_to posts_path, alert: "あなたはこの投稿を編集できません" unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    # 投稿者以外が更新できないようにチェック
    if @post.user == current_user && @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    # 投稿者以外が削除できないようにチェック
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました"
    else
      redirect_to post_path(@post), alert: '削除する権限がありません。'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image)  # 画像も許可
  end
end
