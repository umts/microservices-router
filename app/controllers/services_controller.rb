class ServicesController < ApplicationController
  def register
    @service = Service.create
    @service.url = params[:url]
    @models = params[:models]
    @models.each{ |m| Model.create(service: @service)}
    render json: @service, 
              except: %i(created_at updated_at id),
              include: :models
  end
end
