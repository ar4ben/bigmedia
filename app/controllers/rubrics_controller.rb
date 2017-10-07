class RubricsController < ApplicationController
  before_action :set_rubric, only: [:show, :edit, :update, :destroy]

  # GET /rubrics
  # GET /rubrics.json
  #def index
  #  @rubrics = Rubric.all
  #end

  # GET /rubrics/1
  # GET /rubrics/1.json
  def show
    @articles = @rubric.articles.order('published_at desc').paginate(:page => params[:page], :per_page => 18)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rubric
      @rubric = Rubric.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rubric_params
      params.require(:rubric).permit(:name)
    end
end
