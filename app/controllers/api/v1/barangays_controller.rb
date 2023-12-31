class Api::V1::BarangaysController < ApplicationController
  def index
    city = Address::City.find_by_id(params[:city_id])
    if city
      barangays = city.barangays
    else
      barangays = Address::Barangay.all
    end
    render json: barangays, each_serializer: BarangaySerializer
  end

  def show
    barangay = Address::Barangay.find(params[:id])
    render json: barangay, each_serializer: BarangaySerializer
  end
end
