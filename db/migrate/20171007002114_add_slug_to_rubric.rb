class AddSlugToRubric < ActiveRecord::Migration
  def change
    add_column :rubrics, :slug, :string
    add_index :rubrics, :slug, unique: true
  end
end
