class NotifierMailer < ActionMailer::Base
  def service_change_error(response_code)
    mail to: CONFIG.fetch(:notification_email),
         subject: 'Service Change Notifier has failed',
         body: "The service change notifier request failed
         with the following status code: #{response_code}."
  end
end
