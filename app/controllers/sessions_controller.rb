# Session controller
class SessionsController < ApplicationController
  # Public: Shows sign-in page.
  def new
  end

  # Public: Creates a new user session.
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to(root_url, notice: t('.created'))
  end

  # Public: Destroys current user session.
  def destroy
    session[:user_id] = nil
    redirect_to(signin_url, notice: t('.destroyed'))
  end
end
