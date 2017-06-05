ActiveAdmin.register Article do
  permit_params :title, :body, tag_list: [], category_ids: []

  filter :title
  filter :body
  filter :categories
  filter :tags

  index do
    column :title
    column :category
    column :created_at
    actions
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
        format.json { render :json => @tags.collect{|t| {:id => t.name, :text => t.name }}}
      end
    end
  end

  form do |f|
    semantic_errors
    inputs :title, :body
    inputs do
      input :categories, :as => :check_boxes
    end
    f.input :tag_list,
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
    actions
  end
end