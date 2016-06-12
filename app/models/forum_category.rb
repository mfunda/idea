class ForumCategory < ActiveRecord::Base
  has_many :forum_posts
  belongs_to :user
end
