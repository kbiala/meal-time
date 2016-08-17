# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  name         :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  facebook_id  :integer
#  access_token :string(255)
#  token_expire :integer
#  github_id    :integer
#

class User < ApplicationRecord
  has_many :meals
  has_many :orders, through: :meals

  validates_presence_of :name, :access_token
  validates_uniqueness_of :facebook_id, :github_id, allow_blank: true
  validate :facebook_or_github

  def facebook_or_github
    unless facebook_id || github_id
      errors.add(:facebook_id, "at least one token must be present")
    end
  end

  def self.from_omniauth(omniauth_hash)
    User.create_with(name: omniauth_hash.info.name, access_token: omniauth_hash.credentials.token,
                     token_expire: omniauth_hash.credentials.expires_at)
         .find_or_create_by(facebook_id: omniauth_hash.uid)
  end

  def self.from_github(code)
    github = Github.new(client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'])
    token = github.get_token(code)
    github.oauth_token = token.token
    github_user = github.get_request('/user')
    User.create_with(name: github_user.login, access_token: token.token)
        .find_or_create_by(github_id: github_user.id)
  end
end
