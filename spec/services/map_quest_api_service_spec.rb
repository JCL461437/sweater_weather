require 'rails_helper'

RSpec.describe MapQuestApiService do
  it 'can #get_lat_long' do
    json_response = File.read('spec/fixtures/slc_lat_long.json')
    stub_request(:get, "/geocoding/v1/address?key=#{Rails.application.credentials.map_quest[:key]}&location=Salt Lake City, UT").to_return(status: 200, body: json_response)
    query = JSON.parse(json_response, symbolize_names: true)
    # query = MapQuestApiService.get_lat_long("Salt Lake City, UT")
  
    expect(query).to be_a Hash

    expect(query).to have_key(:info)
    expect(query[:info]).to be_a(Hash)
    expect(query[:info][:statuscode]).to eq(0)

    expect(query).to have_key(:results)
    expect(query[:results]).to be_a(Array)

    expect(query[:results][0][:providedLocation]).to be_a(Hash)
    expect(query[:results][0][:providedLocation][:location]).to eq("Salt Lake City, UT")

    expect(query[:results][0][:locations][0][:latLng]).to be_a(Hash)
    expect(query[:results][0][:locations][0][:latLng]).to eq({:lat=>40.76031, :lng=>-111.88822})
  end
end