require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    it 'responds with status code 200' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
