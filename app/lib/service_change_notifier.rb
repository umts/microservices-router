require 'net/http'

module ServiceChangeNotifier
  def notify_services_of_changes (initiating_service)
    Service.each do |s|
      next if (s.id == initiating_service.id)
      request = Net::HTTP.post_form(URI(s.url),
                                    'services' =>
                                      Service.all.to_json(include: :models))
      if request.nil?
        Net::HTTP.post_form(URI(s.url),
                            'error' => 'Request is nil')
      else
        if request != Net::HTTPSuccess
          send_mail(status)
          request.retry
        end
      end
    end
  end
end
