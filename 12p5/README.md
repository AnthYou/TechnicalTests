# 12p5 - Technical test

The goal is to write a small webapp that find the available spots for a parking place and to display them. The user should be able to book a divided place in an available spot.
You will have to pass the first unit tests below and write all needed tests you need, using the TDD workflow.
## Initialize the project

### Create the rails app skipping tests  
`rails new 12p5-test -T`  

### Setup RSpec  
Go to the Gemfile and add the RSpec gem in the development and test group:  
```ruby
group :development, :test do
  gem 'rspec-rails'
end
```  
Then in your terminal, run  
`bundle install` 

Then setup RSpec in your app by running  
`rails generate rspec:install`  

### Generate the models  
`rails g model Parking name address status picture price_per_cm:integer`  
`rails g model Place name status parking:references`  
`rails g model DividedPlace name status place:references`  

### Add these lines in the db/seed.rb to populate your database
```ruby
Parking.create!(
  name: 'Parking 12.5 x Gardes 5',
  address: '5 rue des Gardes, 75018, Paris',
  price_per_cm: 15,
  status: 'available',
  picture: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
)
```  