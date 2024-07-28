require 'rails_helper'

RSpec.describe Vertical, type: :model do
  describe 'associations' do
    it { should have_many(:categories).dependent(:destroy) }
    it { should accept_nested_attributes_for(:categories) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }

    it 'is expected that name is unique across both veticals and categories' do
      create(:category, name: 'Duplicate')
      expect(build(:vertical, name: 'Duplicate')).not_to be_valid
    end
  end
end
