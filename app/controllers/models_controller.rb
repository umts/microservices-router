class ModelsController < ApplicationController
  def index
    render json: Service.all, include: :models
  end
end
