class UsersController < ApplicationController

  def create
      user = User.create(user_params)
      if user.valid?
          session[:user_id] = user.id
          render json: user
      else
          render json: {message: "Unsucsessful"}, status: :unprocessable_entity
      end
  end

  def show
      user = User.find_by(id: session[:user_id])
      if user
          render json: user
      else
          render json: {message: "User not found"}, status: :unauthorized
      end
  end

  def user_params
      params.permit(:username, :password, :password_confirmation)
  end
end