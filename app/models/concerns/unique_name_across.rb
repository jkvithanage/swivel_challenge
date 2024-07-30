module UniqueNameAcross
  extend ActiveSupport::Concern

  included do
    validate :unique_name_across_models
  end

  private

  def unique_name_across_models
    return unless Vertical.exists?(name: name) || Category.exists?(name: name)

    errors.add(:name, 'must be unique across Verticals and Categories')
  end
end