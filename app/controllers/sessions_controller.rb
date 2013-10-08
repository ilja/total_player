class SessionsController < ApplicationController
  protect_from_forgery :except => :create

  def create
    user = Identity.find(env["omniauth.auth"]["uid"])
    session[:user_id] = user.id


    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end