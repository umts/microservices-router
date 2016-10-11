require 'net/http'

module ServiceChangeNotifier
  def self.notify_services_of_changes
    Service.all.each do |s|
      request = Net::HTTP.post_form(URI(s.url), Service.all.to_json(include: :models))
      if request.nil?
        Net::HTTP.post_form(URI(s.url), 'an error occurred with the request')
      end
    end
  end
end