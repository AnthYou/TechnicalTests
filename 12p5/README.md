# 12p5 - Technical test

The goal is to write a small webapp that find the available spots for a parking place and to display them. The user should be able to book a divided place in an available spot.
You will have to pass the first unit tests below and write all needed tests you need, using the TDD workflow.
## Initialize the project

### 1. Create the rails app skipping tests  
`rails new DouzepCinqTechTest -T`  

### 2. Setup RSpec  
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

### 3. Generate the models  
`rails g model Parking name address status picture_url`  
`rails g model Place name status parking:references`  
`rails g model DividedPlace name status place:references`  

Then run the migrations  
`rails db:migrate`

### 4. Add these lines in the db/seeds.rb to populate your database
```ruby

# Parkings
Parking.create!(
  name: 'Parking 12.5 x Gardes 5',
  address: '5 rue des Gardes, 75018, Paris',
  status: 'available',
  picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
)
Parking.create!(
  name: 'Parking 12.5 x Pyrénées 53',
  address: '53 rue des Pyrénées, 75020, Paris',
  status: 'available',
  picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
)
Parking.create!(
  name: 'Parking 12.5 x Esquirol',
  address: '7 rue Esquirol, 75013, Paris',
  status: 'available',
  picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
)

# Places
Parking.all.each do |parking|
  5.times do |number|
    Place.create!(
      name: "Place #{number + 1} - #{parking.name}",
      status: 'available',
      parking: parking
    )
  end
end

# DividedPlaces
Place.all.each do |place|
  rand(5..8).times do |number|
    DividedPlace.create!(
      name: "Divided place #{number + 1} - #{place.name}",
      status: 'available',
      place: place
    )
  end
end

```  

Then run the seed  
`rails db:seed`

#### 5. Add the following specs
