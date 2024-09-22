require 'rails_helper'

RSpec.describe MapQuestApiService do
  it 'can #get_lat_long' do

    query = MapQuestApiService.get_lat_long("Salt Lake City, UT")
  
    expect(query).to be_a Hash
    binding.pry
    expect(query).to have_key(:info)
    expect(query[:info]).to be_a(String)
    binding.pry
    expect(query).to have_key(:results)
    expect(query[:results]).to be_a(String)
    binding.pry
    expect(query).to have_key(:locations)
    expect(query[:results][1][:locations]).to be_a(String)
    binding.pry
    expect(query).to have_key(:displayLatLng)
    expect(query[:results][1][:locations][1][:latLng]).to be_a(Hash)
    binding.pry
  end
end