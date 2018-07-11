class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :facebook_id, :github_id, :access_token
end
