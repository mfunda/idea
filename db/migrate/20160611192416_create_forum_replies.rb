class CreateForumReplies < ActiveRecord::Migration
  def change
    create_table :forum_replies do |t|
    	t.string :content
    	t.references :user
      t.timestamps null: false
    end
    add_index :forum_replies, :user_id
  end
end
