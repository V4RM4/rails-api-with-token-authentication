module Api::V1
   class AuthenticationController < ApplicationController
      skip_before_action :authenticate_request #Authentication is skipped
  
      # Login method fetches email and password as inbound parameters.
      # A token is encoded using user's id fetched using email,
      # and the token is rendered out as json.
      def login
           @user = User.find_by_email(params[:email])
           if @user&.authenticate(params[:password])
              token = jwt_encode(user_id: @user.id)
              render json: { token: token }, status: :ok
           else
              render json: { error: 'unauthorized' }, status: :unauthorized
           end
      end
  end  
end