class Public::HomesController < ApplicationController
  def top
    @posts = Post.order('id DESC').limit(5) #新着postを降順に5件取得
  end

  def about
  end
end
