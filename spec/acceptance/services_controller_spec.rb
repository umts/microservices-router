require 'rails_helper'

resource 'Services' do
  post '/services/register' do
    parameter :service, @service_1
    example 'Creating and returning a nested data structure' do
      expect{do_request}
        .to change{Service.count}
        .by 1
      body = JSON.parse response_body
      expect(body).not_to be_empty
      #Need to verify returned is a nested data structure
    end
    example 'Returns empty if service already exists and has all models registered' do
      @service_1 = create :service
      @model_1 = create :model, service: @service_1
      @model_2 = create :model, service: @service_1
      do_request
      body = JSON.parse response_body
      expect(body).to be_empty
    end
    example 'Returns empty with model name collision' do
    end
  end
end
