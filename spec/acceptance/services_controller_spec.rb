require 'rails_helper'

resource 'Services' do
  post '/services/register' do
    let(:service_1) { create :service }
    let(:service_2) { create :service }
    let(:model_1) { create :model, service: service_1 }
    let(:model_2) { create :model, service: service_1 }
    let(:model_3) { create :model }
    example 'Creating and returning a nested data structure' do
      data = {url: service_1.url, models:[{name: model_1.name}, {name: model_2.name}]}
      expect{do_request(service: data)}
        .to change{Service.count}
        .by 1
      body = JSON.parse response_body
      body.deep_symbolize_keys!
      expect(body).not_to be_empty
      #need to check for nested data structure
    end
    example 'Returns empty if service already exists and has all models registered' do
      do_request 
      body = JSON.parse response_body
      expect(body).to be_empty
    end
    example 'Returns unprocessable entity with model name collision' do
      do_request
      body = JSON.parse response_body
      expect(body).to eql ({status: 'Service already exists and has all models registered'})
    end
  end
end
