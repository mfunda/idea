class AddCategoryReferenceToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :category_id, :integer, references: :categories
  end
end
