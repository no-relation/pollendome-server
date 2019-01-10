class Api::V1::AuthController < Api::V1::ApplicationController
    skip_before_action :check_authentication

    def create 
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            render json: {
                token: JWT.encode({ user_id: user.id }, 'I_KNOW_WHAT_I_KNOW')
            }
        else
            render json: {
                error: 'username or password are incorrect', 
                status: 401
            }
        end
    end

end