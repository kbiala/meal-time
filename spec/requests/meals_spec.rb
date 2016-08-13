require 'rails_helper'

RSpec.describe "Meals API", type: :request do
  describe '/orders/:order_id/meals POST' do
    it 'successfully creates a meal' do
      order = create(:order)

      expect {
        post "/orders/#{order.id}/meals", params: { meal: { name: 'new_meal', price: 10 } }
      }.to change(Meal, :count).by(1)

      expect(response).to have_http_status(201)
    end

    it 'returns bad request when invalid params given' do
      order = create(:order)

      expect {
        post "/orders/#{order.id}/meals", params: {}
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(400)

      expect {
        post "/orders/#{order.id}/meals", params: { meal: { bad_key: 'value' } }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(400)
    end

    it 'returns not found when invalid order id given' do
      create(:order)
      expect {
        post "/orders/999/meals", params: { meal: { name: 'new_meal', price: 10 } }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(404)
    end

    it 'returns bad request when order is finalized' do
      order = create(:order)
      order.status = 'Finalized'
      order.save!

      expect {
        post "/orders/#{order.id}/meals", params: { meal: { name: 'new_meal', price: 10 } }
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(400)
    end
  end

  describe '/orders/:order_id/meals/:id GET' do
    it 'successfully returns a meal' do
      meal = create(:meal)

      get "/orders/#{meal.order.id}/meals/#{meal.id}"

      new_meal = JSON.parse(response.body)
      expect(response).to be_success
      expect(new_meal['name']).to eq(meal.name)
      expect(new_meal['price']).to eq(meal.price)
      expect(new_meal['order_id']).to eq(meal.order.id)
    end

    it 'returns not found when bad id given' do
      meal = create(:meal)

      get "/orders/#{meal.order.id}/meals/999"
      expect(response).to have_http_status(404)
    end
  end

  describe '/orders/:order_id/meals/:id DELETE' do
    it 'successfully deletes a meal' do
      meal = create(:meal)

      expect {
        delete "/orders/#{meal.order.id}/meals/#{meal.id}"
      }.to change(Meal, :count).by(-1)

      expect(response).to have_http_status(204)
    end

    it 'returns not found when bad id given' do
      meal = create(:meal)

      expect {
        delete "/orders/#{meal.order.id}/meals/999"
      }.to change(Meal, :count).by(0)

      expect(response).to have_http_status(404)
    end
  end
end
