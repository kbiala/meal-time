class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :facebook_id, :access_token
end
