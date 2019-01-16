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
        if params[:startdate][5..6] == params[:enddate][5..6]
            days = Day.where(fulldate: params[:startdate]..params[:enddate])
        else
            # 30 days has September, April, June, and November...
            lastdate = {
                "01": 31,
                "02": 28,
                "03": 31,
                "04": 30,
                "05": 31,
                "06": 30,
                "07": 31,
                "08": 31,
                "09": 31,
                "10": 31,
                "11": 30,
                "12": 31,
            }
            year1 = params[:startdate][0..3]
            month1 = params[:startdate][5..6]
            date1 = lastdate[month1.to_sym]
            enddate = "#{year1}-#{month1}-#{date1}"
            days1 = Day.where(fulldate: params[:startdate]..enddate)
            year2 = params[:enddate][0..3]
            month2 = params[:enddate][5..6]
            date2 = "01"
            days2 = Day.where(fulldate: "#{year2}-#{month2}-#{date2}"..params[:enddate])
            days = days1 + days2
        end
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