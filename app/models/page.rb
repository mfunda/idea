class Page < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: [:slugged, :finders]

	belongs_to :user

end
