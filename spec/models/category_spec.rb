require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    Category.new(name: 'Nando Restaurant')
  end

  before { subject.save }

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
