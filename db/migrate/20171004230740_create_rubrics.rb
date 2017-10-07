class CreateRubrics < ActiveRecord::Migration
  def change
    create_table :rubrics do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
