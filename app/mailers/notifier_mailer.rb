class NotifierMailer < ApplicationMailer
  def service_change_error(response_code)
    mail(from: 'transit-it@admin.umass.edu',
         to: 'programmers@admin.umass.edu',
         subject: "Service Change Notifier has a #{response_code} error")
  end
end
