class ServicesController < ApplicationController
  include ServiceChangeNotifier
  def register
    changes_made = false
    service = Service.find_or_create_by url: params.require(:url)
    service_models = service.models.pluck :name
    param_models = params.require(:models)
    param_models.each do |model_data|
      model = Model.find_by name: model_data.require(:name)
      if model.present?
        head :unprocessable_entity and return if model.service != service
      else
        Model.create(name: model_data.require(:name), service: service)
        changes_made = true
      end
    end
    param_models = param_models.map { |h| h.fetch(:name) }
    old_models = service_models - param_models
    if old_models.present?
      old_models.each do |old_name|
        Model.find(old_name).destroy
      end
    end
    notify_services_of_changes if changes_made
    render json: service,
           only: :url,
           include: { models: { only: :name } }
  end
end
