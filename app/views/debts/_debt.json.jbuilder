json.extract! debt, :id, :owed, :limit, :rate, :payment, :user_id, :created_at, :updated_at
json.url debt_url(debt, format: :json)
