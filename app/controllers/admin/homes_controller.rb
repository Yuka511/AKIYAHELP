class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top #ユーザー一覧ページ
    @users = User.all
  end
end
