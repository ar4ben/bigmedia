class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_most_popular, only: [:index, :show]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.order('created_at desc').paginate(:page => params[:page], 
                                                          :per_page => 18)
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

  def set_most_popular
    @most_popular = Article.where(
      'published = :t and published_at >= :seven_days_ago', 
      { t: true, seven_days_ago: Time.now - 7.days }
    ).order('views desc').limit 6
  end
end