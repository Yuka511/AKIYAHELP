class Public::FavoritesController < ApplicationController
  #before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    current_user.favorites.create(post_id: @post.id)
    # favorite = current_user.favorites.new(post_id: @post.id)
    # favorite.save
    #redirect_to request.referer（いいね非同期通信化の際に、削除）
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    #redirect_to request.referer（いいね非同期通信化の際に、削除）
  end
  
end
