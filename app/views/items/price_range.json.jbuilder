json.array! @price_range do |range|
  json.id range.id
  json.name range.name
  json.min range.min
  json.max range.max
end