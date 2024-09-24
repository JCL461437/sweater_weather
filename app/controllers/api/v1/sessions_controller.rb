class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user), status: 200
    else
      render json: LoginErrorSerializer.new.error, status: 401
    end
  end
end
