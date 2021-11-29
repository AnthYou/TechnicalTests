# 12p5 - Technical test

The goal is to write a small webapp that find the available spots for a one parking place and to display them. The user should be able to book a divided place in an available spot.
You will have to pass the first unit tests below and write all needed tests you need, using the TDD workflow.
## Initialize the project

1. Create the rails app
`rails new 12p5-test`

2. Generate the models
`rails g model Parking name address status picture price_per_cm:integer`
`rails g model Place name status parking:references`
`rails g model DividedPlace name status place:references`

3. Add these lines in the db/seed.rb
```ruby
Parking.create!(
  name: 'Parking 12.5 x Gardes 5',
  address: '5 rue des Gardes, 75018, Paris',
  price_per_cm: 15,
  status: 'available',
  picture: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
)
```
