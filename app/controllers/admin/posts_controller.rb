class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def index
    @posts = Post.includes(:user).order('id DESC') # 投稿を新着順に取得し、関連するユーザー情報も同時に取得
  end
  
end