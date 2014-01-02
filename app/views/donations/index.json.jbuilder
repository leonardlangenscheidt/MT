json.array!(@donations) do |donation|
  json.extract! donation, :id, :amount, :name, :comment
  json.url donation_url(donation, format: :json)
end
