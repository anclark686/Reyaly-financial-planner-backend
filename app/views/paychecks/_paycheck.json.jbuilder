json.extract! paycheck, :id, :date, :user_id, :created_at, :updated_at
json.url paycheck_url(paycheck, format: :json)
