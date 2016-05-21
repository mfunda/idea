class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	has_many :comments

	validates :title, presence: true, length: { maximum: 255 }, uniqueness: true
	validates :content, presence: true, length: { maximum: 10000 }

	has_attached_file :image, styles: { large: "550x450>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
