class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @user =User.find(params[:id])
    @posts = @user.posts.order(id: :desc)
  end

  def destoroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
end
