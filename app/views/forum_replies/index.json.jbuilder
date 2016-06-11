json.array!(@forum_replies) do |forum_reply|
  json.extract! forum_reply, :id
  json.url forum_reply_url(forum_reply, format: :json)
end
