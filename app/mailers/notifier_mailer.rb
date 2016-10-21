class NotifierMailer < ApplicationMailer
  def service_change_error(response_code)
    CONFIG.fetch(:notification_email)
    mail to: 'transit-it@admin.umass.edu',
         subject: 'Service Change Notifier has failed',
         body: "The service change notifier request failed
         with the following status code: #{response_code}."
  end
end
