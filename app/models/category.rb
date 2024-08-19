class Category < ApplicationRecord
  searchkick word_middle: [:name]
  include UniqueNameAcross
  belongs_to :vertical
  has_many :courses, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :state, presence: true

  enum :state, { active: 'active', inactive: 'inactive' }, suffix: true, default: 'active'

  accepts_nested_attributes_for :courses, allow_destroy: true
end
