require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  def auth_stub
    {
      'provider' => 'github',
      'uid' => '1',
      'info' => {
        'nickname' => 'foo',
        'name' => 'Foo Bar',
        'image' => 'http://example.com/image.jpg',
      },
    }
  end

  describe 'GET new' do
    it 'responds with status code 200' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET create' do
    before do
      @auth = auth_stub

      # Builds an user corresponds to auth
      @user = FactoryGirl.build_stubbed(
        :user,
        provider: @auth['provider'],
        uid: @auth['uid'],
      )

      request.env['omniauth.auth'] = auth_stub

      allow(User).to receive(:from_omniauth).with(@auth).and_return(@user)
    end

    it 'calls User.from_omniauth with auth' do
      expect(User).to receive(:from_omniauth).with(@auth).and_return(@user)
      get :create
    end

    it 'stores the user id to session' do
      get :create
      expect(session[:user_id]).to eq(@user.id)
    end

    it 'responds with status code 302' do
      get :create
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to root url' do
      get :create
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'GET destroy' do
    before do
      session[:user_id] = 1
    end

    it 'clear the user id from session' do
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'responds with status code 302' do
      get :destroy
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to sign-in url' do
      get :destroy
      expect(response).to redirect_to(signin_url)
    end
  end
end
