require 'net/http'

module ServiceChangeNotifier
  def notify_services_of_changes (initiating_service)
    Service.all.each do |s|
      next if (s.url.nil? or s.id == initiating_service.id)
      request = Net::HTTP.post_form(URI(s.url),
                                    'services' =>
                                      Service.all.to_json(include: :models))
      if request.nil?
        Net::HTTP.post_form(URI(s.url),
                            'error' => 'Request is nil')
      elsif request == Net::HTTPSuccess
      else
        send_mail(status)
        request.retry
      end
    end
  end
end
