require 'rails_helper'

RSpec.describe ClientProfile, type: :model do
  describe 'associations' do
    it { should belong_to(:client) }
    it { should have_many(:payment_settings) }
    it { should have_many(:payment_methods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:company_name) }
    it { should accept_nested_attributes_for(:client) }
  end
end
