class AddPreviewimageToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :preview_img, :string
  end
end
