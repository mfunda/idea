class Category < ActiveRecord::Base
	has_many :posts
	belongs_to :user
	validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
