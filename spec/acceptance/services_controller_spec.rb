require 'rails_helper'

resource 'Services' do
  post '/services/register' do
    let(:service_1) { create :service }
    let(:model_1) { create :model, service: service_1 }
    let(:model_2) { create :model, service: service_1 }
    parameter :url, 'Unique identifier for services', required: true
    parameter :models, 'Models to be assigned to a specific service', required: true
    example 'Returning a nested data structure on previously registered services' do
      service_data = { url: service_1.url,
                       models: [{ name: model_1.name }, { name: model_2.name }] }
      expect { do_request(service_data) }
        .not_to change { Service.count }
      expect(status).to be status_code :ok
      body = JSON.parse response_body
      body.deep_symbolize_keys!
      expect(body).to eql service_data
    end
    example 'Creating and returning a nested data structure' do
      service_data = { url: 'PiVTrAck.org',
                       models: [{ name: 'amazing model' }] }
      expect { do_request(service_data) }
        .to change { Service.count }
        .by 1
      body = JSON.parse response_body
      body.deep_symbolize_keys!
      expect(body).to eql service_data
    end
    example 'Doing nothing if model exists and has a service' do
      service_data = { url: 'UMassTransit.com',
                       models: [{ name: model_1.name }] }
      expect { do_request(service_data) }
        .not_to change { Model.count }
      expect(status).to be status_code :unprocessable_entity
      expect(response_body).to be_empty
    end
  end
end
