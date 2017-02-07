require 'rails_helper'

resource 'NotifierMailer' do
  let(:service_1) { create :service }
  example 'Returning a nested data structure for registered service' do
    email = NotifierMailer.send_mail(service_1.url, '404')
    expect(email.body).to include 'status code 404.'
    expect(email.body).to include "service #{service_1.url}"
  end
end

describe 'ServiceChangeNotifier' do
  include ServiceChangeNotifier
  describe 'notify_services_of_changes' do
    let!(:service_1) { create :service }
    let!(:service_2) { create :service }
    let!(:model_1) { create :model, service: service_1 }

    it 'Notifies all services with a list of all services/models' do
      expected_params = [
        { url: service_1.url,
          models: [{ name: model_1.name }]
        },
        { url: service_2.url,
          models: []
        }
        ].to_json
      expect(Net::HTTP).to receive(:post_form)
        .with(URI(service_1.url), 'services' => expected_params)
        .and_return Net::HTTPResponse.new('1.0', '200', '')
      notify_services_of_changes(service_2)
    end

    it 'Does not notify the service that caused the changes' do
      expect(Net::HTTP).to receive(:post_form)
        .with(anything, anything)
        .and_return Net::HTTPResponse.new('1.0', '200', '')
        expect(Net::HTTP).not_to receive(:post_form)
          .with(URI(service_2.url), 'services' => anything)
      notify_services_of_changes(service_2)
    end

    it 'Sends mail when a service responds with an error' do
      expect(Net::HTTP).to receive(:post_form)
        .with(URI(service_1.url), 'services' => anything)
        .and_return Net::HTTPNotFound.new('1.0', '404', '')
      notify_services_of_changes(service_2)
    end
  end
end
