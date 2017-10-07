class ApplicationController < ActionController::Base
    before_action :set_most_popular, only: [:index, :show]
  before_action :set_categories_rubrics, only: [:index, :show]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def access_denied(exception)
    Rails.logger.error "access denied! '#{exception.message}'"
    flash[:warning] = "access denied! '#{exception.message}'"
    redirect_to admin_root_url
  end

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found_error', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  def server_error
    respond_to do |format|
      format.html { render template: 'errors/server_error', layout: 'layouts/error', status: 500 }
      format.all  { render nothing: true, status: 500 }
    end
  end

  private

    def set_most_popular
    @most_popular = Article.where(
      'published = :t and published_at >= :seven_days_ago', 
      { t: true, seven_days_ago: Time.now - 7.days }
    ).order('views desc').limit 6
  end

  def set_categories_rubrics
    @categories = Category.all.order('created_at desc')
    @rubrics = Rubric.all.order('created_at desc')
  end

  def set_meta
    set_meta_tags description: @article.lead,
                  keywords: @article.tag_list,
                  og: {
                    title: @article.title,
                    type: 'article',
                    url: request.original_url,
                    image: @article.preview_img,
                    description: @article.lead
                  }
  end
end
