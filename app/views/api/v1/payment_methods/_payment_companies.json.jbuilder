json.array! @companies do |company|
  json.id company.id
  json.name company.name
  json.image url_for(company.image)
end
