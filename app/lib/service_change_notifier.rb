require 'net/http'

module ServiceChangeNotifier
  def notify_services_of_changes(initiating_service)
    Service.all.each do |s|
      next if s.id == initiating_service.id
      response = Net::HTTP.post_form(URI(s.url),
                                    'services' =>
                                      Service.all.to_json(only: :url,
                                      include: { models: { only: :name }}))
      if !response.is_a? Net::HTTPSuccess
        NotifierMailer.send_mail(s.url, response.code)
      end
    end
  end
end
