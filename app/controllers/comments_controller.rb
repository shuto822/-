class CommentsController < ApplicationController
  before_action :authenticate_user!

  # コメントの詳細表示
  def show
    @post = Post.find(params[:post_id])  # 対象の投稿を取得
    @comment = @post.comments.find(params[:id])  # 対象のコメントを取得
  end

  # コメント作成
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: "コメントを投稿しました"
    else
      redirect_to post_path(@post), alert: "コメントを投稿できませんでした"
    end
  end

  # コメント削除
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
