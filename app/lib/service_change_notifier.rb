require 'net/http'

module ServiceChangeNotifier
  def notify_services_of_changes(initiating_service)
    Service.all.each do |service|
      next if service == initiating_service
      response = Net::HTTP.post_form(URI(service.url),
                                     'services' =>
                                     Service.all.to_json(only: :url,
                                                         include:
                                       { models:
                                         { only: :name } }))
      unless response.is_a? Net::HTTPSuccess
        NotifierMailer.send_mail(service.url, response.code)
      end
    end
  end
end
