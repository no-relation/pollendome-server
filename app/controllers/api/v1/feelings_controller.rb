class Api::V1::FeelingsController < Api::V1::ApplicationController
    before_action :define_current_feeling

    def create
        day = Day.find_or_create_by(fulldate: params[:fulldate])
        feeling = Feeling.create(rating: params[:rating], user_id: params[:user_id], day_id: day.id)
        render json: feeling.user.feelings
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

    def userfind
        user = User.find(params[:id])
        feelings = user.feelings
        days = user.feelings.map{ |feeling| feeling.day }
        render json: feelings.zip(days).map{|k,v| {feeling: k, day: v}}
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