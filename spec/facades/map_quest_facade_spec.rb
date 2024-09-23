require "rails_helper"

RSpec.describe WeatherFacade do
  it "will make a poros from the json using the get_lat_long method" do
    location = "Salt Lake City, UT" #slc lat long values 

    response = MapQuestFacade.new.lat_long(location)

    expect(response).to be_a(String)

    expect(response).to eq("40.76031,-111.88822")
  end
end