require 'rails_helper'

resource 'Services' do
  include ServiceChangeNotifier
  post '/services/register' do
    let(:service_1) { create :service }
    let(:model_1) { create :model, service: service_1 }
    let(:model_2) { create :model, service: service_1 }
    parameter :url, 'Unique identifier for services', required: true
    parameter :models, 'Models assigned to a specific service', required: false

    example 'Returning a nested data structure for registered service' do
      explanation 'A registered service and its models are returned.'
      service_data = { url: service_1.url,
                       models: [model_1.name, model_2.name].join(', ') }
      expect_any_instance_of(ServicesController)
        .not_to receive :notify_services_of_changes
      expect { do_request(service_data) }
        .not_to change { Service.count }
      expect(status).to be status_code :ok
      body = JSON.parse response_body
      body.deep_symbolize_keys!
      expect(body).to eql url: service_1.url, models: [{ name: model_1.name }, { name: model_2.name }]
    end
    example 'Creating and returning a nested data structure' do
      explanation 'A service and its models are created and returned.'
      service_data = { url: 'https://www.example.com/abc',
                       models: 'amazing_model' }
      expect_any_instance_of(ServicesController)
        .to receive :notify_services_of_changes
      expect { do_request(service_data) }
        .to change { Service.count }
        .by 1
      body = JSON.parse response_body
      body.deep_symbolize_keys!
      expect(body).to eql url: 'https://www.example.com/abc', models: [{ name: 'amazing_model' }]
    end
    example 'Creating and returning a simple service' do
      explanation 'A service with no models is still valid.'
      service_data = { url: 'https://www.example.com' }
      expect { do_request service_data }
        .to change(Service, :count).by 1
      expect(status).to be status_code :ok
    end
    example 'Doing nothing for a model with a service' do
      explanation 'A model can only be assigned to one service.'
      service_data = { url: 'https://www.example.com/bus',
                       models: model_1.name }
      expect_any_instance_of(ServicesController)
        .not_to receive :notify_services_of_changes
      expect { do_request(service_data) }
        .not_to change { Model.count }
      expect(status).to be status_code :unprocessable_entity
      expect(response_body).to be_empty
    end
    example 'Updating a registered service sends a notification' do
      service_data = { url: model_1.service.url,
                       models: 'hello_there' }
      expect_any_instance_of(ServicesController)
        .to receive :notify_services_of_changes
      expect { do_request(service_data) }
        .not_to change { Model.count }
    end
  end
end
