class ServicesController < ApplicationController
  include ServiceChangeNotifier
    def register
      service = Service.find_or_create_by url: params.require(:url)
      params.require(:models).each do |model_data|
        model = Model.find_by name: model_data.require(:name)
        if model.present?
          head :unprocessable_entity and return if model.service != service
        else
          Model.create(name: model_data.require(:name), service: service)
        end
      end
      render json: service,
             only: :url,
             include: { models: { only: :name } }
      ServiceChangeNotifier.notify_services_of_changes if (service.changed? || service.models.each{|m| m.changed?}.present?)
  end
end
