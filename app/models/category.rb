class Category < ApplicationRecord
  belongs_to :vertical
  has_many :courses, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :state, presence: true

  validate :unique_name_across_verticals

  enum :state, { active: 'active', inactive: 'inactive' }, suffix: true, default: 'active'

  accepts_nested_attributes_for :courses, allow_destroy: true

  private

  def unique_name_across_verticals
    return unless Vertical.exists?(name:)

    errors.add(:name, 'must be unique across Verticals and Categories')
  end
end
