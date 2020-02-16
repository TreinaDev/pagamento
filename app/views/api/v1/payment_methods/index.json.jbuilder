json.array! @payment_methods do |payment_method|
  json.id payment_method.id
  json.name payment_method.name

  json.payment_companies do
    json.partial! 'api/v1/payment_methods/payment_companies',
                  payment_companies: payment_method.payment_companies
  end
end
