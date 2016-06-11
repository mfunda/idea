class ForumPost < ActiveRecord::Base
	belongs_to :user
	has_many :forum_replies
end
