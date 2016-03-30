class Category < ActiveRecord::Base
	has_many :posts

	validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
