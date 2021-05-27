# README
http://musik-store.herokuapp.com/

A Ruby on Rails backend Restful API with a basic crud structure and pagination created with TDD and a full test suite, JSON Serialized Endpoints, Seeded Data from the Spotify API and JWT Auth set up ready to go.

Using Rails 6, Ruby 2.6.7 

Don't forget to `bundle` and `rails db:migrate`
`rails db:seed` to record & artist data 

`bundle exec rspec spec` to run the test suite 

Enjoy! 

_Currently in development with extensions to come and soon to be connected to VUE frontend APP...._
________________________________________________________________________________________________

***All Private endpoints require a header with Auth token from Authorization endpoint for a valid user***

headers: ```{"Authorization" => "Bearer <AUTH_TOKEN>" }```

Sample User Info >> ```username: "system_user"``` ```password: "qwerty"```

Verb | EndPoint | Auth | Required | Description | Output
---- | -------- | ---- | -------- | ----------- |------
POST | /api/v1/authenticate | Public | Authenticate a valid user | ```{ username: "string_value", password: "string_value }``` | ```{'token' => 'JWT_AUTH_TOKEN'}``` 
GET  | /api/v1/records | Public | N/A | Display all Records |  Object with key ```'records':``` [array_ of records]  and ```'meta':``` meta_data.
DELETE | /api/v1/records/:id | Private | Delete a single Record |  valid ```record_id``` in url | ```{'status': 'status_info'} ```
GET | /api/v1/users/:user_id/likes | Private | Display all likes for a particular user |  valid ```user_id``` in url | Object with key ```likes:``` [array_ of likes] for given user and ```meta:``` meta_data.
POST | /api/v1/records/:record_id/likes | Private | Create a new like for a particular record |  ```record_id: record_id``` in body | ```{ 'status': 'status_info' }```
DELETE | /api/v1/records/:record_id/likes/:id | Private | Delete a like for a particular record |  ```record_id``` & ```like_id``` in url | ```{ 'status': 'status_info' }```

