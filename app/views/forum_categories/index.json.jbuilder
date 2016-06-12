json.array!(@forum_categories) do |forum_category|
  json.extract! forum_category, :id, :name, :ForumPost_id, :User_id
  json.url forum_category_url(forum_category, format: :json)
end
