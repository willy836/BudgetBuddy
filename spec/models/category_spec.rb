require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { Category.new(name: 'Test Category') }

  before { subject.save }

  describe 'validations' do
    it 'should have a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe '#total_amount' do
    it 'returns total_amount of a category' do
      expect(subject.total_amount).to eq(subject.products.sum(:amount))
    end
  end

  describe '#recent_products' do
    it 'returns recent products ordered in descending order' do
      expect(subject.recent_products).to eq(subject.products.order(created_at: :desc))
    end
  end
end
