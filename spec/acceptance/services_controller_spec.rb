require 'rails_helper'

resource 'Services' do
  post '/services/register' do
    let(:service_1) { create :service }
    let(:model_1) { create :model, service: service_1 }
    let(:model_2) { create :model, service: service_1 }
    example 'Doing nothing on already registered services and models' do
      service_data = { url: service_1.url, models:[{name: model_1.name}, {name: model_2.name}] }
      expect{ do_request(service_data) }
        .not_to change{ Service.count }
      expect(status).to be status_code(:no_content)
    end
  end
end
