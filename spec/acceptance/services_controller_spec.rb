require 'rails_helper'

resource 'Services' do
  post '/services/register' do
    let(:service_1) { create :service }
    let(:model_1) { create :model, service: service_1 }
    let(:model_2) { create :model, service: service_1 }
    example 'Creating and returning a nested data structure' do
      service_data = {url: service_1.url, models:[{name: model_1.name}, {name: model_2.name}]}
      expect{do_request(service_data)}
        .to change{Service.count}
        .by 1
      body = JSON.parse response_body
      body.deep_symbolize_keys!
      expect(body).to eql service_data
    end
  end
end
