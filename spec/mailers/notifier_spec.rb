require 'rails_helper'

describe 'NotifierMailer' do
  describe 'send_mail' do
    it 'Correctly reports the status code in the email body' do
      email = NotifierMailer.send_mail('404')
      expect(email.body).to include 'status code: 404.'
    end
  end
end

describe 'ServiceChangeNotifier' do
  include ServiceChangeNotifier
  describe 'notify_services_of_changes' do
    let(:service_1) { create :service }
    let(:model_1) { create :model, service: service_1 }

    it 'Notifies the things' do
      service_2 = create :service
      expected_params = [
        { url: service_2.url,
          models: []
        },
        { url: service_1.url,
          models: [{ name: model_1.name }]
          }
        ].to_json
      expect(Net::HTTP).to receive(:post_form)
        .with(URI(service_1.url), 'services' => expected_params)
        .and_return double(status: 200)
      notify_services_of_changes(service_2)
    end
    # example 'Services without URLs are not notified of service changes' do
    #   service_no_url = create :service, url: nil
    #   service_data = { url: 'https://www.example.com/abc', models: 'amazing_model' }
    #   expect(service_1).not_to receive :notify_services_of_changes
    #   do_request(service_data)
    # end
  end
end
