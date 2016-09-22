class ServicesController < ApplicationController
  def register
    @service = Service.create(url: params[:url])
    if params[:models].present?
      @models = params[:models]
      @models.each{ |m| Model.create(service: @service)}
    end
    render json: {url: @service.url, models: @models},
              except: %i(created_at updated_at id)        
  end
end
