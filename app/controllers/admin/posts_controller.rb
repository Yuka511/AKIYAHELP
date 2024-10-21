class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def index
    @posts = Post.order('id DESC') #postを降順(新着順)に取得
  end
  
end