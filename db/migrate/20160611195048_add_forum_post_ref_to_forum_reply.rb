class AddForumPostRefToForumReply < ActiveRecord::Migration
  def change
  	add_column :forum_replies, :forum_post_id, :integer
	change_column :forum_replies, :forum_post_id, :integer, references: :forum_posts
  end
end
