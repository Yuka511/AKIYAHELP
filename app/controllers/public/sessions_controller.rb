# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    mypage_path # ログイン直後は、ユーザーの詳細ページ(マイページ)へ遷移
  end

  def after_sign_out_path_for(resource)
    about_path # ログアウト直後は、aboutページへ遷移
  end

  def guest_sign_in #ゲストログイン機能
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "ゲストでログインしました。"
  end
  
def destroy
  if current_user && current_user.email == User::GUEST_USER_EMAIL
    reset_guest_data
  end
  super
end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
