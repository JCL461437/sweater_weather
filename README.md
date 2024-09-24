# README
## About Sweater Weather
Sweater Weather is an application to plan road trips. This app will allow users to see the current weather as well as the forecasted weather at the destination. 

## Using Sweater Weather
### Cloning the Repository Locally 
To use Sweater Weather, fork the repository, and then run `git clone "SHH key"` after acquiring you SHH key (this can be done by clicking the green code button near the top right of your screen when viewing your forked repository. 

### Creating the Database and Installing Dependencies
To use Sweater Weather, you first must create the database, run migrations, and install the required gems. To create and migrate the tables for Sweater Weathers database run `rails db:{create,migrate}` in the terminal. 

To install the required gems, run `bundle install` in the terminal.

### Running the Test Suite 
To run the Sweater Weather test suite, in the terminal while in the sweater weather directory run `bundle exec rspec spec`. This will run all of the tests. Conversley, you can navigate to which ever test(s) you want to run in the `spec` directory if you do not want to run the entire suite. 

## Endpoints
Sweater Weather has a variety endpoints for client consumption. There JSON payloads along with the required request formatting is described below

## `GET /api/v1/forecast?location=chosen_location`
To get a valid response, you must provide this endpoints query param `location` with a valid location. For instance, `location=new york city, ny`, `london`, and `location=Hong Kong` are all valid requests. 

Leaving the field empty OR entering an invalid location will result in an error. The resulting json response will look like this: 
` {
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-04-07 16:30",
        "temperature": 55.0,
        etc
      },
      "daily_weather": [
        {
          "date": "2023-04-07",
          "sunrise": "07:13 AM",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00",
          "temperature": 54.5,
          etc
        },
        {...} etc
      ]
    }
  }
}`

## `POST /api/v1/road_trip`

## Additional Information
* Ruby version: 3.2.2

* Rails version: 7.1.4

* Services (job queues, cache servers, search engines, etc.)
