class ServicesController < ApplicationController
  def register
    @service = Service.create
    render json: @service, include: :models
  end
end
