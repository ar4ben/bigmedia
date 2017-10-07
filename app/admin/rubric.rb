ActiveAdmin.register Rubric do
  permit_params :name
  filter :name

  index do
    column :name
    actions
  end

  controller do
    def find_resource
      #for finding via slugs
      scoped_collection.friendly.find(params[:id])
    end
  end

  form do |f|
    semantic_errors
    inputs :name
    actions
  end
end
