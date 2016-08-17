require 'rails_helper'

RSpec.describe "Users API", type: :request do
  #describe '/users POST' do
  #  it 'successfully creates a user' do
  #    expect {
  #      post '/users', params: { user: { name: "John", facebook_id: 1 } }
  #    }.to change(User, :count).by(1)

  #    user = JSON.parse(response.body)
  #    expect(response).to have_http_status(201)
  #    expect(user['name']).to eq("John")
  #    expect(user['facebook_id']).to eq(1)
  #  end
  #end

  #describe '/users/:id GET' do
  #  it 'successfully returns a user' do
  #    user = create(:user)

  #    get "/users/#{user.id}"

  #    returned_user = JSON.parse(response.body)
  #    expect(response).to be_success
  #    expect(returned_user['name']).to eq(user.name)
  #    expect(returned_user['facebook_id']).to eq(user.facebook_id)
  #  end

  #  it 'returns not found when invalid id given' do
  #    create(:user)

  #    get "/users/999"

  #    expect(response).to have_http_status(404)
  #  end
  #end
end
