json.array!(@users) do |user|
  json.extract! user, :first_name, :last_name_string, :nick_name, :login_name, :notes
  json.url user_url(user, format: :json)
end
