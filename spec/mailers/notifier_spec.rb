require 'rails_helper'

resource 'NotifierMailer' do
  example 'Returning a nested data structure for registered service' do
    email = NotifierMailer.send_mail('404')
    expect(email.body).to include 'status code: 404.'
  end
end

resource 'ServiceChangeNotifier' do
  # include ServiceChangeNotifier
  post '/services/register' do
    let(:service_1) { create :service }
    let(:model_2) { create :model, service: service_1 }
    parameter :url, 'Unique identifier for services', required: true
    parameter :models, 'Models assigned to a specific service', required: false

    example 'Services are notified when a change is triggered' do
      let(:model_1) { create :model, service: service_1 }
      service_data = { url: 'https://www.example.com/abc', models: 'amazing_model' }
      expect(Net::HTTP).to receive(:post_form).with(URI(service_1.url), services: {  }) 
      do_request(service_data)
    end
    # example 'Services without URLs are not notified of service changes' do
    #   service_no_url = create :service, url: nil
    #   service_data = { url: 'https://www.example.com/abc', models: 'amazing_model' }
    #   expect(service_1).not_to receive :notify_services_of_changes
    #   do_request(service_data)
    # end
  end
end
