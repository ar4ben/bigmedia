class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  # GET /categories.json
  #def index
  #  @categories = Category.all
  #end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @articles = @category.articles.order('published_at desc').paginate(:page => params[:page], :per_page => 18)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name)
  end
end
