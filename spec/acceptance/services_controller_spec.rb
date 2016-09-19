require 'rails_helper'

resource 'Services' do
  post '/services/register' do
    example 'Creating and returning a nested data structure' do
      expect{do_request}
      .to change{Service.count}
      .by 1
      body = JSON.parse response_body
    end
  end
end
