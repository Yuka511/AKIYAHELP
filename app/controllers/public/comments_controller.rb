class Public::CommentsController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end
  
  #ストロングパラメータ
  private
  
  def comment_params
     params.require(:comment).permit(:body)
  end  
  
end
