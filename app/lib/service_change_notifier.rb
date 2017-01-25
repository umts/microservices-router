require 'net/http'

module ServiceChangeNotifier
  def notify_services_of_changes (initiating_service)
    # binding.pry
    Service.all.each do |s|
      next if (s.id == initiating_service.id)
      response = Net::HTTP.post_form(URI(s.url),
                                    'services' =>
                                      Service.all.to_json(only: :url,
                                      include: { models: { only: :name }}))
      if response.nil?
        Net::HTTP.post_form(URI(s.url),
                            'error' => 'response is nil')
      else
        if response != Net::HTTPSuccess
          NotifierMailer.send_mail(response.status)
          response.retry
        end
      end
    end
  end
end
