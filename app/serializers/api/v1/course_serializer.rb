class Api::V1::CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :author, :state

  belongs_to :category
end
