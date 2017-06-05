module V1
  class RoutesController < ActionController::Base
    def new
      routes = GoogleMapService.new(route_params).perform
      render json: routes
    end

    private

    def route_params
      params.permit(
        :begin_lat,
        :begin_long,
        :end_lat,
        :end_long
      )
    end
  end
end
