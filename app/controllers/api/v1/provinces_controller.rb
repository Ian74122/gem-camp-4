class Api::V1::ProvincesController < ApplicationController
  def index
    region = Address::Region.find_by_id(params[:region_id])
    if region
      provinces = region.provinces
    else
      provinces = Address::Province.all
    end
    render json: provinces, each_serializer: ProvinceSerializer
  end

  def show
    province = Address::Province.find(params[:id])
    render json: province, serializer: ProvinceSerializer
  end
end
