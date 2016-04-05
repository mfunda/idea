class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	has_many :comments

	validates :title, presence: true, length: { maximum: 255 }, uniqueness: true
	validates :content, presence: true, length: { maximum: 10000 }
end
