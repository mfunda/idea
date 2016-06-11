class AddUserReferencesToForumPost < ActiveRecord::Migration
  def change
  	add_column :forum_posts, :user_id, :integer
	change_column :forum_posts, :user_id, :integer, references: :users
  end
end
