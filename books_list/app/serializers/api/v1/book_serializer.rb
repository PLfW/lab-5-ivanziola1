class Api::V1::BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :description, :rating, :approved, :genres
end
