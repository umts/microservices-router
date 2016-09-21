require 'rails_helper'

resource 'Services' do
  post '/services/register' do
    let(:service_1) { create :service, url: 'hotcakes-now.com' }
    let(:service_2) { create :service, url: 'massivebus.com'}
    let(:model_1) { create :model, service: service_1 }
    let(:model_2) { create :model, service: service_1 }
    let(:model_3) { create :model }
    example 'Creating and returning a nested data structure' do
      data = {url: service_1.url, models:[{name: model_1.name}, {name: model_2.name}]}
      expect{do_request(data)}
        .to change{Service.count}
        .by 1
      body = JSON.parse response_body
      body.deep_symbolize_keys!
      expect(body).not_to be_empty
      #need to check for nested data structure
    end
  end
end
