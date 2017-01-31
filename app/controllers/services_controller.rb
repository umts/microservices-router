class ServicesController < ApplicationController

  include ServiceChangeNotifier

  def register
    changes_made = false
    changed_service = nil
    service = Service.find_or_create_by url: params.require(:url)
    service_model_names = service.models.pluck :name
    param_model_names = []
    if params[:models].present?
      params[:models].split(', ').each do |model_name|
        param_model_names << model_name
        model = Model.find_by name: model_name
        # binding.pry
        if model.present?
          head :unprocessable_entity and return if model.service != service
        else
          Model.create(name: model_name, service: service)
          changes_made = true
          changed_service = service.id
        end
      end
      old_model_names = service_model_names - param_model_names
      if old_model_names.present?
        old_model_names.each do |old_name|
          Model.find_by(name: old_name).destroy
        end
      end
    end
    notify_services_of_changes(changed_service)
    render json: Service.all,
           only: :url,
           include: { models: { only: :name } }
  end
end
