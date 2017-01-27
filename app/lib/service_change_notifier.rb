require 'net/http'

module ServiceChangeNotifier
  def notify_services_of_changes (initiating_service)
    # binding.pry
    Service.all.each do |s|
      next if (s.id == initiating_service.id)
      # binding.pry
      response = Net::HTTP.post_form(URI(s.url),
                                    'services' =>
                                      Service.all.to_json(only: :url,
                                      include: { models: { only: :name }}))
      # binding.pry
      if !response.is_a? Net::HTTPSuccess
        NotifierMailer.send_mail(response.code)
        # response.retry
      end
    end
  end
end
