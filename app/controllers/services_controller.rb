class ServicesController < ApplicationController
  def register
    @service = Service.create(params[:id])
    if @service.save
      render json: @service, 
            except: %i(created_at updated_at id),
            include: :models  
    else
      render json: {status: 'Service already exists and has all models registered'}
    end
  end
end
