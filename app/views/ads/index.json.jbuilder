json.array!(@ads) do |ad|
  json.extract! ad, :id, :user_id, :model_id_id, :year, :details, :price, :millage, :expration, :fuel_type, :girbox, :body_color_id, :internal_color_id, :active
  json.url ad_url(ad, format: :json)
end
