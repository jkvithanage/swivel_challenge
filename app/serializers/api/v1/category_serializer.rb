class Api::V1::CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :state

  belongs_to :vertical
  has_many :courses
end
