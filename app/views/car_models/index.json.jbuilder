json.array!(@car_models) do |car_model|
  json.extract! car_model, :id, :name, :make_id
  json.url car_model_url(car_model, format: :json)
end
