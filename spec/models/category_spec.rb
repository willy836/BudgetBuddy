require 'rails_helper'

RSpec.describe Category, type: :model do
    subject { Category.new(name: 'John Restaurant') }

    before { subject.save }

    it 'should have a name' do
        subject.name = nil
        expect(subject).to_not be_valid
    end
end