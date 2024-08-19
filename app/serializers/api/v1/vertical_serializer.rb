class Api::V1::VerticalSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :categories
end
