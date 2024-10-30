class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @user =User.find(params[:id])
    @posts = @user.posts.order(id: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_path
  end
end
