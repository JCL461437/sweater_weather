class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user)
    else
      render json: JsonErrorSerializer.bad_user_input
    end
  end
  
  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end