class SessionsController < ApplicationController
  def create
    user = User.where(username: params[:username]).first
    if user
      session[:user_id] = user.id
      redirect_to todos_path
    else
      flash[:error] = "This application is invite only."
      redirect_to front_page_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
