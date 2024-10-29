class ApplicationController < ActionController::Base
  
  private

  def reset_guest_data
    guest_user = User.find_by(email: User::GUEST_USER_EMAIL)
    guest_user.posts.destroy_all if guest_user.posts.any?
    guest_user.comments.destroy_all if guest_user.comments.any?
    guest_user.favorites.destroy_all if guest_user.favorites.any?
    guest_user.followings.destroy_all if guest_user.followings.any?
  end

end
