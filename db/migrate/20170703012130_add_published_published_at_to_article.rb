class AddPublishedPublishedAtToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :published, :boolean, default: false
    add_column :articles, :published_at, :datetime, null: false, :default => Time.now
  end
end
