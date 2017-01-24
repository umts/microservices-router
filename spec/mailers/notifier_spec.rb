require 'rails_helper'

resource 'NotifierMailer' do
  let(:service_1) { create :service }
  example 'Returning a nested data structure for registered service' do
    email = NotifierMailer.send_mail(service_1.url, '404')
    expect(email.body).to include 'status code 404.'
    expect(email.body).to include "service #{service_1.url}"
  end
end
