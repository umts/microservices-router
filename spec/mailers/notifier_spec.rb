require 'rails_helper'

resource 'NotifierMailer' do
  example 'Returning a nested data structure for registered service' do
    email = NotifierMailer.send_mail('www.example.com', '404')
    expect(email.body).to include 'status code 404.'
    expect(email.body).to include 'service www.example.com'
  end
end
