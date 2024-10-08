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

Leaving the field empty OR entering an invalid location will result in an error. 

The resulting json response for a successful request will look like this: 



<img width="464" alt="Screenshot 2024-09-24 at 9 58 46 AM" src="https://github.com/user-attachments/assets/5ff0f6b7-e58b-4d0b-a705-e3a3ae76f977">




## `POST /api/v1/users`
To get a valid response, you must provide this endpoint with a JSON payload in the body of your request. The format of this request should looks as follows:


<img width="396" alt="Screenshot 2024-09-25 at 8 44 12 AM" src="https://github.com/user-attachments/assets/58daa274-2b8d-442d-aea5-56b78f5ca9e4">


If any of the keys in this request payload are not filled with valid values you will recieve an error.

A successful response will return the following JSON: 


<img width="480" alt="Screenshot 2024-09-25 at 8 44 22 AM" src="https://github.com/user-attachments/assets/679042ba-1867-4627-b034-cab5afa1abe7">


## `POST /api/v1/sessions`
To get a valid response, you must provide this endpoint with a JSON payload in the body of your request. The format of this request should looks as follows:



<img width="364" alt="Screenshot 2024-09-25 at 8 46 48 AM" src="https://github.com/user-attachments/assets/884dad40-20d7-466c-be42-038b15c4ccca">




If any of the keys in this request payload are not filled with valid values you will recieve an error.

A successful response will return the following JSON: 



<img width="479" alt="Screenshot 2024-09-25 at 8 46 55 AM" src="https://github.com/user-attachments/assets/87739905-9c36-4707-a83f-75b42399453a">



## Additional Information
* Ruby version: 3.2.2

* Rails version: 7.1.4

* Services (job queues, cache servers, search engines, etc.)
