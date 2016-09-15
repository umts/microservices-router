require 'rails_helper'
require 'rspec_api_documentation/dsl'

describe ModelsController do
  describe 'GET #index' do
    let(:service_1) { create :service }
    let(:service_2) { create :service }
    let!(:model_1){ create :model, service: service_1 }
    let!(:model_2){ create :model, service: service_1 }
    let!(:model_3){ create :model, service: service_2 }
    it 'renders JSON with services and their models' do
      get :index, format: :json
      body = JSON.parse response.body
      body.each(&:deep_symbolize_keys!)
      expect(body).to eql [
        { url: service_1.url,
          models: [ { name: model_1.name }, { name: model_2.name } ] },
        { url: service_2.url, models: [ { name: model_3.name } ] }
      ]
    end
  end
end
