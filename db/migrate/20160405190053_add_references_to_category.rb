class AddReferencesToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :user_id, :integer, references: :users
  end
end
