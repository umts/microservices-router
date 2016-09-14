require 'rails_helper'

describe ModelsController do
  describe 'GET #index' do
    it 'returns a nonempty JSON' do
      get :index, format: :json
      expect(response.status).to be (204)
    end
  end
end
