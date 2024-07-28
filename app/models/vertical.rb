class Vertical < ApplicationRecord
  has_many :categories

  validates :name, presence: true, uniqueness: true

  validate :unique_name_across_categories

  private

  def unique_name_across_categories
    return unless Category.exists?(name:)

    errors.add(:name, 'must be unique across Verticals and Categories')
  end
end
