class Api::V1::CitiesController < ApplicationController
  def index
    province = Address::Province.find_by_id(params[:province_id])
    if province
      cities = province.cities
    else
      cities = Address::City.all
    end
    render json: cities, each_serializer: CitySerializer
  end

  def show
    city = Address::City.find(params[:id])
    render json: city, each_serializer: CitySerializer
  end
end
