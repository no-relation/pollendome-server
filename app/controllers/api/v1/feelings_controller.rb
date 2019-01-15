class Api::V1::FeelingsController < Api::V1::ApplicationController
    before_action :define_current_feeling

    def create
        feeling = Feeling.create(feeling_params)
        render json: feeling
    end

    def index
        render json: Feeling.all
    end

    def show
        render json: current_feeling
    end

    def update
        current_feeling.update(feeling_params)
        render json: current_feeling
    end

    def destroy
        current_feeling.destroy
        render json: current_feeling
    end

    def define_current_feeling
        if params[:id]
            @current_feeling = Feeling.find(params[:id])
        else
            @current_feeling = Feeling.new
        end
    end

    def current_feeling
        @current_feeling
    end

    def feeling_params
        params.permit(:rating, :user_id, :day_id)
    end
end