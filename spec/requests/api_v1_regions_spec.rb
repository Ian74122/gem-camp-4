require 'rails_helper'

RSpec.describe "ApiV1Regions", type: :request do
  describe "GET /api_v1_regions" do
    before do
      allow_any_instance_of(ClientDomainConstraint).to receive(:matches?).and_return(true)
    end
    it "should return 200 when we call api" do
      get api_v1_regions_path
      expect(response.status).to eq 200
    end

    it "should return a json" do
      get api_v1_regions_path
      obj = JSON.parse(response.body)
      expect(obj.class).to eq Array
    end

    it "should return json with one element" do
      region = Address::Region.create(code: 'foo', name: 'bar')
      get api_v1_regions_path
      obj = JSON.parse(response.body)
      expect(obj.size).to eq 1
      expect(obj[0]['name']).to eq(region.name)
      expect(obj[0]['id']).to eq(region.id)
    end

    it "should return json with two element" do
      region = Address::Region.create(code: 'foo', name: 'bar')
      region_2 = Address::Region.create(code: 'foo_2', name: 'bar_2')
      get api_v1_regions_path
      obj = JSON.parse(response.body)
      expect(obj.size).to eq 2
      expect(obj[0]['name']).to eq(region.name)
      expect(obj[0]['id']).to eq(region.id)
      expect(obj[1]['name']).to eq(region_2.name)
      expect(obj[1]['id']).to eq(region_2.id)
    end

    it 'should let the return data only with name and code' do
      Address::Region.create(code: 'foo', name: 'bar')
      get api_v1_regions_path
      obj = JSON.parse(response.body)
      expect(obj[0].size).to eq 2
      expect(obj[0].keys).to eq %w[id name]
    end
  end
end
