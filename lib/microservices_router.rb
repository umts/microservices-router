require 'net/http'

module ServiceChangeNotifier
  def notify_services_of_changes
    Service.all.each do |s|
      unless s.url.nil?
        request = Net::HTTP.post_form(URI(s.url), {'services' => Service.all.to_json(include: :models)} )
        if request.nil?
          Net::HTTP.post_form(URI(s.url), {'error' => 'an error occurred with the request'})
        end
      end
    end
  end
end