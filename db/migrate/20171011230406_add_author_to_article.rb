class AddAuthorToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :author, :string
    add_index(:articles, :author)
  end
end
