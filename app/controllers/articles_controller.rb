class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  before_action :set_meta, only: [:show]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.find_with_pagination(params)
    @first = true if [nil,"1"].include? params[:page]
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article.update( 
      views: @article.views + 1
    )
    @relevant_articles = Article.tagged_with(@article.tag_list, :any => true)
                         .where.not(id: @article.id).order('views desc').limit(3)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.friendly.find(params[:id])
  end


end