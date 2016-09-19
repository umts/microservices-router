class ServicesController < ApplicationController
  def create
    @service = Service.new
    render json: @service, include: :models
  end
end
