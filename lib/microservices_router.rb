require 'net/http'

module ServiceChangeNotifier
  def notify_services_of_changes
    Service.all.each do |s|
      next if s.url.nil?
      request = Net::HTTP.post_form(URI(s.url),
                                    'services' =>
                                      Service.all.to_json(include: :models))
      if request.nil?
        Net::HTTP.post_form(URI(s.url),
                            'error' => 'Request is nil')
      elsif request == Net::HTTPSuccess
      else
      service_change_error(status)
      request.retry
      end
    end
  end
end
