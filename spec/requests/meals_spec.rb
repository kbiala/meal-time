require 'rails_helper'

RSpec.describe "Meals API", type: :request do
  let(:current_user) { create(:user_with_github) }

  describe '/orders/:order_id/meals POST' do
    it 'successfully creates a meal' do
      order = create(:order)

      expect {
        post "/orders/#{order.id}/meals", params: {
          meal: { name: 'new_meal', price: 10, user_id: current_user.id },
          access_token: current_user.access_token
        }
      }.to change(Meal, :count).by(1)

      expect(response).to have_http_status(201)
    end

    it 'return unauthorized when invalid token given' do
      order = create(:order)

      expect {
        post "/orders/#{order.id}/meals", params: {
          meal: { name: 'new_meal', price: 10, user_id: current_user.id },
        }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(401)
    end

    it 'returns bad request when invalid params given' do
      order = create(:order)

      expect {
        post "/orders/#{order.id}/meals", params: {
          meal: { user_id: current_user.id },
          access_token: current_user.access_token
        }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(400)

      expect {
        post "/orders/#{order.id}/meals", params: {
          meal: { bad_key: 'value', user_id: current_user.id },
          access_token: current_user.access_token
        }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(400)
    end

    it 'returns not found when invalid order id given' do
      create(:order)

      expect {
        post "/orders/999/meals", params: {
          meal: { name: 'new_meal', price: 10, user_id: current_user.id },
          access_token: current_user.access_token
        }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(404)
    end

    it 'returns bad request when order is finalized' do
      order = create(:order)
      order.status = 'Finalized'
      order.save!

      expect {
        post "/orders/#{order.id}/meals", params: {
          meal: { name: 'new_meal', price: 10, user_id: current_user.id },
          access_token: current_user.access_token
        }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(400)
    end
  end

  describe '/orders/:order_id/meals/:id GET' do
    it 'successfully returns a meal' do
      meal = create(:meal)

      get "/orders/#{meal.order.id}/meals/#{meal.id}", params: { access_token: current_user.access_token }

      new_meal = JSON.parse(response.body)
      expect(response).to be_success
      expect(new_meal['name']).to eq(meal.name)
      expect(new_meal['price']).to eq(meal.price)
      expect(new_meal['order_id']).to eq(meal.order.id)
      expect(new_meal['user_id']).to eq(meal.user.id)
      expect(new_meal['username']).to eq(meal.user.name)
    end

    it 'returns unauthorized when invalid token given' do
      meal = create(:meal)

      get "/orders/#{meal.order.id}/meals/#{meal.id}"

      expect(response).to have_http_status(401)
    end

    it 'returns not found when bad id given' do
      meal = create(:meal)

      get "/orders/#{meal.order.id}/meals/999", params: { access_token: current_user.access_token }
      expect(response).to have_http_status(404)
    end
  end

  describe '/orders/:order_id/meals/:id DELETE' do
    it 'successfully deletes a meal' do
      current_user
      meal = create(:meal)

      expect {
        delete "/orders/#{meal.order.id}/meals/#{meal.id}", params: { access_token: current_user.access_token }
      }.to change(Meal, :count).by(-1).and change(User, :count).by(0).and change(Order, :count).by(0)

      expect(response).to have_http_status(204)
    end

    it 'returns unauthorized when invalid token given' do
      meal = create(:meal)

      expect {
        delete "/orders/#{meal.order.id}/meals/#{meal.id}"
      }.to change(Meal, :count).by(0).and change(User, :count).by(0).and change(Order, :count).by(0)

      expect(response).to have_http_status(401)
    end

    it 'returns not found when bad id given' do
      meal = create(:meal)

      expect {
        delete "/orders/#{meal.order.id}/meals/999", params: { access_token: current_user.access_token }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(404)
    end
  end
end
