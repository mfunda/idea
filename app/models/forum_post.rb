class ForumPost < ActiveRecord::Base
	belongs_to :user
	belongs_to :forum_category
	has_many :forum_replies
end
