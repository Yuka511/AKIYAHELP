class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @content = params[:content]
    @method = params[:method]
    
    # ユーザーとポストの検索結果を取得
    user_records = User.search_for(@content, @method)
    post_records = Post.search_for(@content, @method)
    
    if params[:model].blank? || params[:model] == "user"
      @model = "user"
      @user_records = user_records
    end
    
    if params[:model].blank? || params[:model] == "post"
      @model = "post"
      @post_records = post_records.order(created_at: :desc) # ここで新着順に並び替える
    end
  end

end
