class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def mypage
    @user = current_user
    @posts = @user.posts.order(id: :desc) #ログインユーザーのpostを降順(新着順)に取得
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc) #指定のuserのpostを降順(新着順)に取得

    if @user == current_user
      redirect_to mypage_path
    else
      render 'show'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_registration_path
  end

  #ストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :email, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end 
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

end
