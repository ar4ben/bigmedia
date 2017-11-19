class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_most_popular, only: [:index, :show]
  before_action :set_categories_rubrics

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
    uri = URI.parse(request.original_url)
    image = if @article.preview_img.include?("http")
              @article.preview_img
            else
              "#{uri.scheme}://#{uri.host}#{@article.preview_img}"
            end
    #image_dim = FastImage.size(image)
    set_meta_tags description: @article.lead,
                  keywords: @article.tag_list,
                  og: {
                    title: @article.title,
                    type: 'article',
                    url: request.original_url,
                    image: image,
                    description: @article.lead
                  }
    #set_meta_tags og: {
    #                image: {
    #                  _: image,
    #                  width: image_dim[0],
    #                  height: image_dim[1]
    #                }
    #              } if image_dim
  end
end
