ActiveAdmin.register Article do
  permit_params :title, :body, :preview_img, :published, :lead, :author, :rubric_id, tag_list: [], category_ids: []

  filter :title
  filter :body
  filter :categories, multiple: :true, :as => :select, input_html: { class: 'prettyselect'}
  filter :rubric, multiple: :true, :as => :select, input_html: { class: 'prettyselect'}
  filter :tags,
          as: :select,
          multiple: :true,
          label: "Tags",
          input_html: {
            data: {
              placeholder: "Enter tags",
              url: "/admin/autocomplete_tags?filter=true"
              },
            class: 'tagselect'
          }

  index do
    column :title
    column (:category) { |user| user.categories.map(&:name).join(', ')}
    column :rubric
    column :created_at
    column :published
    actions
  end

  show do
    attributes_table do
      row :preview do |article| 
        link_to "Посмотреть в отдельной вкладке", article_path(article), target: :_blank
      end
      default_attribute_table_rows.each do |field|
        if field == :body
          row :body do |article| 
            article.body.html_safe 
          end
        elsif field == :preview_img
          row :preview_img do |article|
            image_tag(article.preview_img)
          end
        else
          row field
        end
      end
    end
  end

  controller do
    def find_resource
      #for finding via slugs
      scoped_collection.friendly.find(params[:id])
    end

    def autocomplete_tags
      @tags = ActsAsTaggableOn::Tag.
        where("name LIKE ?", "#{params[:q]}%").
        order(:name)
      respond_to do |format|
        if params[:filter]
          format.json { render :json => @tags.collect{|t| {:id => t.id, :text => t.name }}}
        else
          format.json { render :json => @tags.collect{|t| {:id => t.name, :text => t.name }}}
        end
      end
    end
  end

  form do |f|
    semantic_errors
    inputs :title 
    inputs do
      input :body, :as => :ckeditor
    end
    inputs :name => "Минимальный размер 200x200px" do
      input :preview_img 
    end
    inputs :lead
    inputs :author, :title => "Имя Фамилия"
    inputs do
      input :categories, :as => :select, input_html: { class: 'prettyselect'}
    end  
    inputs do
      input :rubric, :as => :select, input_html: { class: 'prettyselect'}
    end
    inputs do
      input :tag_list,
        as: :select,
        multiple: :true,
        label: "Tags",
        collection: f.object.tags.map{|t| [t.name,:selected=> true]},
        input_html: {
          data: {
            placeholder: "Enter tags",
            url: autocomplete_tags_path 
            },
          class: 'tagselect'
        }
    end
    inputs do
      input :published, :as => :select, input_html: { class: 'prettyselect'}
    end  if current_admin_user.has_any_role? :super_admin, :admin
    actions
  end
end