require 'rails_helper'

describe ModelsController do
  describe 'GET #index' do
    it 'is not empty' do
      get :index
      expect(response).not_to be_empty
    end
  end
end
