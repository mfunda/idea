class ChangeForumPostAndReplyContentType < ActiveRecord::Migration
  def change
  	change_column :forum_posts, :content, :text
  	change_column :forum_replies, :content, :text
  end
end
