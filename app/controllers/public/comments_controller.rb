class Public::CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
    # redirect_to request.referer（コメント非同期通信化の際に、削除）
  end
  
  def destroy
    # Comment.find(params[:id]).destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    # redirect_to request.referer（コメント非同期通信化の際に、削除）
  end
  
  #ストロングパラメータ
  private
  
  def comment_params
     params.require(:comment).permit(:body)
  end  
  
end
