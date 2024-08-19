class Vertical < ApplicationRecord
  searchkick word_middle: [:name]
  include UniqueNameAcross
  has_many :categories, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :categories, allow_destroy: true
end
