class StaticPagesController < ApplicationController

  def home
    @articles = Article.paginate(page: params[:page], per_page: 9).order('updated_at DESC')
  end
end
