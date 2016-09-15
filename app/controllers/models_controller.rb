class ModelsController < ApplicationController
  def index
    render json: Service.all, 
    except: %i(created_at updated_at id), 
    include: { models: { only: :name }}
  end
end
