class Course < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :author, presence: true
  validates :state, presence: true

  enum :state, { active: 'active', inactive: 'inactive' }, suffix: true, default: 'active'
end
