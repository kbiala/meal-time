require 'rails_helper'

RSpec.describe "Orders API", type: :request do
  describe '/orders GET' do
    it 'successfully returns orders' do
      create_list(:order, 3)

      get '/orders'

      orders = JSON.parse(response.body)

      expect(response).to be_success
      expect(orders.count).to eq(3)
    end
  end

  describe '/orders/:id GET' do
    it 'successfully returns an order' do
      order = create(:order)

      get "/orders/#{order.id}"

      returned_order = JSON.parse(response.body)
      expect(response).to be_success
      expect(returned_order['name']).to eq(order.name)
      expect(returned_order['status']).to eq(order.status)
    end

    it 'returns not found when invalid id given' do
      create(:order)

      get "/orders/999"

      expect(response).to have_http_status(404)
    end
  end

  describe '/orders POST' do
    it 'successfully created a new order' do
      expect {
        post '/orders', params: { order: {name: 'new_order'} }
      }.to change(Order, :count).by(1)

      new_order = JSON.parse(response.body)

      expect(response).to have_http_status(201)
      expect(new_order['name']).to eq('new_order')
    end

    it 'returns bad request when invalid params given' do
      expect {
        post '/orders', params: { order: {} }
      }.to change(Order, :count).by(0)

      expect(response).to have_http_status(400)
    end
  end

  describe '/orders/:id PUT' do
    it 'successfully updates order' do
      order = create(:order)

      put "/orders/#{order.id}", params: { order: { name: 'new_name', status: 'Finalized'} }

      new_order = JSON.parse(response.body)

      expect(response).to be_success
      expect(new_order['name']).to eq('new_name')
      expect(new_order['status']).to eq('Finalized')
    end

    it 'returns ok when nothing updated' do
      order = create(:order)

      put "/orders/#{order.id}", params: { order: { bad_key: 'value'} }

      new_order = JSON.parse(response.body)
      expect(response).to be_success
      expect(new_order['name']).to eq(order.name)
      expect(new_order['status']).to eq(order.status)
    end

    it 'returns bad request when no valid params given' do
      order = create(:order)

      put "/orders/#{order.id}"

      expect(response).to have_http_status(400)
    end

    it 'returns not found when bad id given' do
      create(:order)

      put "/orders/999", params: { order: { name: 'new_name' } }

      expect(response).to have_http_status(404)
    end
  end

  describe '/orders/:id DELETE' do
    it 'successfully deletes an order' do
      order = create(:order)

      expect {
        delete "/orders/#{order.id}"
      }.to change(Order, :count).by(-1)

      expect(response).to have_http_status(204)
    end

    it 'returns not found when bad id given' do
      create(:order)

      expect {
        delete "/orders/999"
      }.to change(Order, :count).by(0)

      expect(response).to have_http_status(404)
    end
  end
end
