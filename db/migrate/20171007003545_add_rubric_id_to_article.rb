class AddRubricIdToArticle < ActiveRecord::Migration
  def change
    add_reference :articles, :rubric, index: true, foreign_key: true
  end
end
