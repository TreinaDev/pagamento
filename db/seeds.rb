# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

client = Client.create(email:'test@test.com', password: '123teste')
ClientProfile.create(cnpj: '111111111-11', company_name: 'Empresa A', 
                     manager: 'Fulano', address: 'Paulista, 1000', 
                     phone: '11-2999-9999', auth_token: 'adhfad12123', 
                     client_id: client.id) 

debito = PaymentMethod.create(name: 'Débito em Conta', tax: 0.01)
pay_co01 = PaymentCompany.create(name: 'MasterCard',
                                 payment_method: debito)
pay_co01.image.attach(io: Rails.root.join('spec/support/mastercard.png'),
                               filename: 'mastercard.png')

paypal = PaymentMethod.create(name: 'Paypal', tax: 0.02)
pay_co02 = PaymentCompany.create(name: 'Paypal',
                                 payment_method: paypal)
pay_co02.image.attach(io: Rails.root.join('spec/support/paypal.png'),
                              filename: 'paypal.png')

boleto = PaymentMethod.create(name: 'Boleto', tax: 0.01)
pay_co03 = PaymentCompany.create(name: 'Boleto',
                                 payment_method: boleto)
pay_co03.image.attach(io: Rails.root.join('spec/support/boleto.png'),
                      filename: 'boleto.png')

credito = PaymentMethod.create(name: 'Cartão de Crédito', tax: 0.02)
pay_co04 = PaymentCompany.create(name: 'Cartão de Crédito',
                                 payment_method: credito)
pay_co04.image.attach(io: Rails.root.join('spec/support/visa.png'),
                              filename: 'visa.png')
