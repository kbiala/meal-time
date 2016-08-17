require 'rails_helper'

RSpec.describe "Sessions API", type: :request do
  FACEBOOK_NAME = 'john'
  FACEBOOK_UID = 12345
  FACEBOOK_TOKEN = 'token1'

  describe "/sessions/authenticate GET" do
    it 'successfully authenticates' do
      user = create(:user_with_facebook)
      get '/sessions/authenticate', params: { access_token: user.access_token }

      returned_user = JSON.parse(response.body)
      expect(response).to be_success
      expect(returned_user['name']).to eq(user.name)
      expect(returned_user['access_token']).to eq(user.access_token)
      expect(returned_user['facebook_id']).to eq(user.facebook_id)
      expect(returned_user['github_id']).to eq(user.github_id)
    end

    it 'returned unauthorized when invalid token given' do
      create(:user)

      get '/sessions/authenticate'

      expect(response).to have_http_status(401)
    end
  end

  describe "/auth/:provider/callback GET" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: FACEBOOK_UID,
      info: { name: FACEBOOK_NAME },
      credentials: { token: FACEBOOK_TOKEN, expires_at: 1.day.from_now.to_i }
    })

    it 'successfully creates a new user' do

      expect {
        get '/auth/facebook/callback', params: { access_token: 'some_token' }
      }.to change(User, :count).by(1)

      new_user = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(new_user['name']).to eq(FACEBOOK_NAME)
      expect(new_user['facebook_id']).to eq(FACEBOOK_UID)
      expect(new_user['access_token']).to eq(FACEBOOK_TOKEN)
    end

    it 'successfully returns an existing user' do
      user = build(:user_with_facebook)
      user.facebook_id = FACEBOOK_UID
      user.save!

      expect {
        get '/auth/facebook/callback', params: { access_token: 'some_token' }
      }.to change(User, :count).by(0)

      returned_user = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(returned_user['name']).to eq(user.name)
      expect(returned_user['facebook_id']).to eq(user.facebook_id)
      expect(returned_user['access_token']).to eq(user.access_token)
    end
  end
end
