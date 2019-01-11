class Api::V1::ApplicationController < ApplicationController
    before_action :check_authentication

    def check_authentication
        if !logged_in_user
            render json: { error: 'Please log in' }, status: 401
        end
    end

    def logged_in_user
        if request.headers['Authorization']
            method, token = request.headers['Authorization'].split(' ')
            begin
                payload, headers = JWT.decode(token, ENV['JWT_secret'])
                current_user = User.find(payload['user_id'])
            rescue JWT::DecodeError
                nil
            end
        end
    end

end