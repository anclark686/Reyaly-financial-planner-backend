json.extract! user, :id, :username, :pay_rate, :pay_freq, :created_at, :updated_at
json.url user_url(user, format: :json)
