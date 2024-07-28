require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should belong_to :vertical }
    it { should have_many :courses }
  end

  describe 'validations' do
    subject { build(:category) }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :state }

    it 'is expected that name is unique across both veticals and categories' do
      create(:vertical, name: 'Duplicate')
      expect(build(:category, name: 'Duplicate')).not_to be_valid
    end
  end
end
