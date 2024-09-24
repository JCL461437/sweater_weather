class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.first_name}!"
      redirect_to user_dashboard_index_path(user.id)
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
  end
end