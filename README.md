# README
A Ruby on Rails backend Restful API with a basic crud structure and pagination created with TDD mindset and a full test suite, JSON Serialized Endpoints, Seeded Data from the Spotify API and JWT Auth set up ready to go.

Currently in development for extensions and soon to be hooked up to a Vue front-end.

Using Rails 6, Ruby 2.6.7 

Don't forget to `bundle` and `rails db:migrate` 

`bundle exec rspec spec` to run the test suite 

Enjoy! 



|Verb | EndPoint | Auth | Required | Output
| --- | --------| ------ | ---------|
| POST | /api/v1/authenticate | Public | { username: <string>, password: <string> } | 
        {'token' => 'JWT_AUTH_TOKEN'} 
| GET  | /api/v1/records | Public | - | An object including an array of record info