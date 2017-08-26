class AddLeadToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :lead, :text
  end
end
