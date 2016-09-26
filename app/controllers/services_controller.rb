class ServicesController < ApplicationController
  def register
    service = Service.find_or_create_by url: params.require(:url)
    params.require(:models).each do |model_data|
      model = Model.find_by name: model_data.require(:name)
      if model.present?
        if model.service != service
          head :unprocessable_entity and return
        end
      else
        Model.create(name: model_data.require(:name), service: service)
      end
    end
    render json: service,
                only: :url,
              include: {models: {only: :name}}
  end
end