class Api::V1::DaysController < Api::V1::ApplicationController
    before_action :define_current_day

    skip_before_action :check_authentication, only: [ :index, :show, :find ]

    def create
        day = Day.create(day_params)
        render json: day
    end

    def index
        render json: Day.all
    end

    def show
        render json: current_day
    end

    def update
        current_day.update(day_params)
        render json: current_day
    end

    def destroy
        current_day.destroy
        render json: current_day
    end

    def find
        # have to build a query for only the params that exist
        query = {}
        if params[:year]
            query[:year] = params[:year]
        end
        if params[:month]
            query[:month] = params[:month]
        end
        if params[:date]
            query[:date] = params[:date]
        end

        days = Day.where( query )
        render json: days
    end

    def define_current_day
        if params[:id]
            @current_day = Day.find(params[:id])
        else
            @current_day = Day.new
        end
    end

    def current_day
        @current_day
    end

    def day_params
        params.permit(:month, :date, :year)
    end
end