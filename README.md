# README

## Version Info
* Ruby version - 3.2.2 | Rails version - 7.0.5

## System dependencies
  * mongoid - 7.3 - to communicate with MongoDB database
  * rack-cors - for CORS usage
  * spreadsheet - used for spreadsheet creation
  * dotenv-rails - for handling of ENV variables 
  * httparty - to assist in crawling websites
  * nokogiri - for parsing HTML

## Configuration
  * Serves as a backend to a Vue JS application
  * No templating
  * MongoDB as the database

##  Get Started
  * Setup .env per the .env.template
  * From the terminal:
    * Run "bundle install"
    * Run "bin/rails server"

## How to run the test suite
  * To run all tests - "bin/rails test"
  * To run model tests - "bin/rails test:models"
  * To run controller tests - "bin/rails test:controllers"
