class UsersController < ApplicationController

    skip_before_action :verify_authenticity_token, only: [:create]

    def create
    puts "Received params: #{params.inspect}"

      @user = User.new(user_params)
  
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :first_name, :last_name)
    end
  end