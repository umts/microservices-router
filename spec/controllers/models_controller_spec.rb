require 'rails_helper'

describe ModelsController do
  describe 'GET #index' do
    let(:fruit_service){ create :service, url: 'https://fruit.example.com/' }
    let(:veggie_service){ create :service, url: 'https://veggies.example.com/' }
    let!(:apple){ create :model, name: 'Apple', service: fruit_service }
    let!(:banana){ create :model, name: 'Banana', service: fruit_service }
    let!(:carrot){ create :model, name: 'Carrot', service: veggie_service }
    it 'renders a JSON with models and services' do
      get :index, format: :json
      body = JSON.parse response.body
      expect(body).to eql [
        { url: 'https://fruit.example.com/', models: [
           { name: 'Apple' }, { name: 'Banana' } 
        ]}.deep_stringify_keys,
        { url: 'https://veggies.example.com/', models: [
          { name: 'Carrot' }
        ]}.deep_stringify_keys
      ]
    end
  end
end
