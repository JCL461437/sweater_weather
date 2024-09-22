require 'rails_helper'

RSpec.describe MapQuestApiService do
  it 'can #get_lat_long' do

    query = MapQuestApiService.get_lat_long("Salt Lake City, UT")
    map_quest = query.first

    expect(query).to be_a Array
    expect(map_quest).to be_a Hash
    binding.pry
    expect(map_quest).to have_key("info")
    expect(map_quest["info"]).to be_a(String)
    binding.pry
    expect(map_quest).to have_key("results")
    expect(map_quest["results"]).to be_a(String)
    binding.pry
    expect(map_quest).to have_key("locations")
    expect(map_quest["results"][1]["locations"]).to be_a(String)
    binding.pry
    expect(map_quest).to have_key("displayLatLng")
    expect(map_quest["results"][1]["locations"][1]["latLng"]).to be_a(Hash)
    binding.pry
  end
end