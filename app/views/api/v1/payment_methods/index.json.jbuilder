json.set! :payment_methods do
  json.array! @payment_methods do |payment_method|
    json.id payment_method.id
    json.name payment_method.name
    json.set! :payment_companies do
      json.array! payment_method.payment_companies do |company|
        json.name company.name
        json.image url_for(company.image)
      end
    end
  end
end
