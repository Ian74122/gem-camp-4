class PhLocationService
  attr_reader :url

  def initialize
    @url = 'https://psgc.gitlab.io/api'
  end

  def fetch_region
    request = RestClient.get("#{url}/regions/")
    data = JSON.parse(request.body)
    data.each do |region|
      address_region = Address::Region.find_or_initialize_by(code: region['code'])
      address_region.name = region['regionName']
      address_region.save
    end
  end

  def fetch_province
    request = RestClient.get("#{url}/provinces/")
    data = JSON.parse(request.body)
    data.each do |province|
      address_province = Address::Province.find_or_initialize_by(code: province['code'])
      address_province.name = province['name']
      address_province.region = Address::Region.find_by_code(province['regionCode'])
      address_province.save
    end
  end

  def fetch_districts
    request = RestClient.get("#{url}/districts/")
    data = JSON.parse(request.body)
    data.each do |district|
      region = Address::Region.find_by(code: district['regionCode'])
      address_district = Address::Province.find_or_initialize_by(code: district['code'])
      address_district.name = district['name']
      address_district.region = region
      address_district.save
    end
  end

  def fetch_cities
    request = RestClient.get("#{url}/cities-municipalities/")
    data = JSON.parse(request.body)
    data.each do |city|
      address_city = Address::City.find_or_initialize_by(code: city['code'])
      address_city.name = city['name']
      address_city.province = if city['districtCode']
                                Address::Province.find_by_code(city['districtCode'])
                              elsif city['provinceCode']
                                Address::Province.find_by_code(city['provinceCode'])
                              end
      address_city.save
    end
    request = RestClient.get("#{url}/cities/")
    data = JSON.parse(request.body)
    data.each do |city|
      address_city = Address::City.find_or_initialize_by(code: city['code'])
      address_city.name = city['name']
      if city['provinceCode']
        address_city.province = Address::Province.find_by(code: city['provinceCode'])
      elsif city['districtCode']
        address_city.province = Address::Province.find_by(code: city['districtCode'])
      elsif city['code'] == '099701000'
        address_city.province = Address::Province.find_by_name('Basilan')
      elsif city['code'] == '129804000'
        address_city.province = Address::Province.find_by_name('Maguindanao')
      end
      address_city.save
    end
  end

  def fetch_barangay
    request = RestClient.get("#{url}/barangays/")
    data = JSON.parse(request.body)
    Parallel.each(data) do |barangay|
      address_barangay = Address::Barangay.find_or_initialize_by(code: barangay['code'])
      address_barangay.name = barangay['name']
      city_code = barangay['cityCode'] ? barangay['cityCode'] : barangay['municipalityCode']
      address_barangay.city = Address::City.find_by(code: city_code)
      address_barangay.save
    end
    puts data.count
  end
end