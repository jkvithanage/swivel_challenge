module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(user_params)

        if @user.save
          return render json: @user, status: :created
        end

        render json: @user.errors, status: :unprocessable_entity
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
