require 'rails_helper'

RSpec.describe User, type: :model do
    subject { User.new(name: 'John Doe') }

    before { subject.save }

    it 'should have a name' do
        subject.name = nil
        expect(subject).to_not be_valid
    end
end