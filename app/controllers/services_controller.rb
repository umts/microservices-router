class ServicesController < ApplicationController
  def register
    url = params.require :url
    if Service.find_by(url: url).present?
      render nothing: true, status: :no_content
    else
      service = Service.create(url: url)
      models = params.require :models
      models.each do |m|
        model_name = m[:name]
        if Model.find_by(name: model_name).present?
        else Model.create(name: model_name, service: service)
        end
      end
    render json: {url: service.url, models: models},
                except: %i(created_at updated_at id)
    end
  end
end