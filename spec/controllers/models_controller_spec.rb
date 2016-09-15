require 'rails_helper'

resource 'Models' do
  get '/models' do
    let(:service_1) { create :service }
    let(:service_2) { create :service }
    let!(:model_1){ create :model, service: service_1 }
    let!(:model_2){ create :model, service: service_1 }
    let!(:model_3){ create :model, service: service_2 }
    example 'Listing all models by service' do
      do_request
      body = JSON.parse response_body
      body.each(&:deep_symbolize_keys!)
      expect(body).to eql [
        { url: service_1.url,
          models: [ { name: model_1.name }, { name: model_2.name } ] },
        { url: service_2.url, models: [ { name: model_3.name } ] }
      ]
    end
  end
end
