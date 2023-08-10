# Reyaly Financial Planner Backend

This app was created as a Capstone project for Ada Developers Academy. This repository is the backend of a full-stack application, more information below.

### Site
https://reyaly-financial-planner.link	

## Features
A full list of application features can be found at https://github.com/anclark686/Reyaly-financial-planner-frontend

### Backend specific features
 - Savings: app will crawl https://www.nerdwallet.com/best/banking/savings-rates - to pull the latest high APY savings accounts
 - Currency Converter: uses external APIs to calculate the conversion, as well as to pull the exchange rate. To obtain an API key, visit https://api-ninjas.com/
 - Excel Export: uses `spreadheet` gem to generate a formatted excel sheet of user data and finances. 

## Project Details
### Configuration
  * Serves as a backend to a Vue JS application
    * https://github.com/anclark686/Reyaly-financial-planner-frontend
  * MongoDB as the database
  * Deployed via Heroku
    * https://reyaly-financial-backend-983411f48872.herokuapp.com/


### Version Info
* Ruby version - 3.2.2 | Rails version - 7.0.5

### System dependencies
  * mongoid - 7.3 - to communicate with MongoDB database
  * rack-cors - for CORS usage
  * spreadsheet - used for spreadsheet creation
  * dotenv-rails - for handling of ENV variables 
  * httparty - to assist in crawling websites
  * nokogiri - for parsing HTML

### Project Setup
  * Setup .env per the .env.template
  * Run the following from the shell

```sh
bundle install
bin/rails server
```

### How to run the test suite

#### To run all tests

```sh
bin/rails test
```
#### To run model tests

```sh
bin/rails test:models
```
#### To run controller tests

```sh
bin/rails test:controllers
```
