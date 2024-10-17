class Public::UsersController < ApplicationController
  def mypage
    @user = current_user
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
  
  #ストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :introduction, :profile_image)
  end
end
