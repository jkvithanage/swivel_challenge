require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should belong_to :category }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :author }
    it { should validate_presence_of :state }
  end
end
