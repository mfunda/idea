class CreateForumCategories < ActiveRecord::Migration
  def change
    create_table :forum_categories do |t|
      t.string :name
      t.references :user
      t.timestamps null: false
    end
    add_index :forum_categories, :user_id
  end
end
