require 'rails_helper'

resource 'NotifierMailer' do
  example 'Returning a nested data structure for registered service' do
    email = NotifierMailer.send_mail('404')
    expect(email.body).to include 'status code: 404.'
  end
end
