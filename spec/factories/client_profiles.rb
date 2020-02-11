FactoryBot.define do
  factory :client_profile do
    company_name { 'Fulano de Tal' }
    cnpj { '1234561232345' }
    manager { 'Felipe' }
    address { 'Rua asdf' }
    phone { '11 99999-9999' }
    email { 'marcelle.sa@teste.com' }
    auth_token { 'QwDASFEQFDFAEFEFE' }
  end
end
