class Vertical < ApplicationRecord
  has_many :categories, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  validate :unique_name_across_categories

  accepts_nested_attributes_for :categories, allow_destroy: true

  private

  def unique_name_across_categories
    return unless Category.exists?(name:)

    errors.add(:name, 'must be unique across Verticals and Categories')
  end
end
