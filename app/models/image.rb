class Image < ActiveRecord::Base
	has_attached_file :name, styles: { large: "800x600>", thumb: "300x300>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :name, content_type: /\Aimage\/.*\Z/
end
