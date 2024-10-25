class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @post = current_user.posts.build #ユーザーが新しい投稿を作成する際に、その投稿に自動的にユーザー情報が関連付けられる（@post = Post.newにユーザー情報の紐づけ）
  end

  def index
    @posts = Post.order('id DESC') #postを降順(新着順)に取得
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "※必須項目をすべて入力してください。"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "※必須項目をすべて入力してください。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  #ストロングパラメータ
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  
  def is_matching_login_user
    post = Post.find(params[:id])
    user = post.user
    unless user.id == current_user.id
      redirect_to posts_path
    end 
  end
  
end
