class AddForumCategoryRefToForumPost < ActiveRecord::Migration
  def change
    add_reference :forum_posts, :forum_category, index: true, foreign_key: true
  end
end
