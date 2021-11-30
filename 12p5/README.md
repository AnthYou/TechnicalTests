# 12p5 - Technical test

The goal is to write a small webapp that find the available spots for every parking place and to display them. Users should be able to book a divided place in an available spot, making the number of remaining spot availables going down.  
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

### 5. Add the following specs  
spec/models/parking_spec.rb  
```ruby
require 'rails_helper'

RSpec.describe Parking, type: :model do
  subject do
    described_class.new(
      name: 'Sample name',
      address: 'Sample address',
      status: 'available',
      picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
    )
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without an address' do
      subject.address = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a status' do
      subject.status = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a picture' do
      subject.picture_url = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'Associations' do
    it 'should have many places' do
      place = Place.new(
        name: 'Sample name',
        status: 'available',
        parking: subject
      )
      place.save

      expect(subject.places.last).to eq(place)
    end

    it 'should have many divided places' do
      divided_place = DividedPlace.new(
        name: 'Sample name',
        status: 'available',
        place: Place.new(
          name: 'Sample name',
          status: 'available',
          parking: subject
        )
      )
      divided_place.save

      expect(subject.divided_places.last).to eq(divided_place)
    end
  end
end
```  
  
spec/models/place_spec.rb  
```ruby
require 'rails_helper'

RSpec.describe Place, type: :model do
  subject do
    described_class.new(
      name: 'Sample name',
      status: 'available',
      parking: Parking.new(
        name: 'Sample name',
        address: 'Sample address',
        status: 'available',
        picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
      )
    )
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a status' do
      subject.status = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'Associations' do
    it 'should belong to a parking' do
      parking = Parking.new(
        name: 'Sample name',
        address: 'Sample address',
        status: 'available',
        picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
      )
      parking.save
      subject.parking = parking
      subject.save

      expect(subject.parking).to eq(parking)
    end

    it 'should have many divided places' do
      divided_place = DividedPlace.new(
        name: 'Sample name',
        status: 'available',
        place: subject
      )
      divided_place.save

      expect(subject.divided_places).to eq([divided_place])
    end
  end
end
```  
  
spec/models/divided_place_spec.rb  
```ruby
require 'rails_helper'

RSpec.describe DividedPlace, type: :model do
  subject do
    described_class.new(
      name: 'Sample name',
      status: 'available',
      place: Place.new(
        name: 'Sample name',
        status: 'available',
        parking: Parking.new(
          name: 'Sample name',
          address: 'Sample address',
          status: 'available',
          picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
        )
      )
    )
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a status' do
      subject.status = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'Associations' do
    it 'should belong to a place' do
      place = Place.new(
        name: 'Sample name',
        status: 'available',
        parking: Parking.new(
          name: 'Sample name',
          address: 'Sample address',
          status: 'available',
          picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
        )
      )
      subject.place = place
      subject.save

      expect(subject.place).to eq(place)
    end

    it 'should belong to a parking' do
      parking = Parking.new(
        name: 'Sample name',
        address: 'Sample address',
        status: 'available',
        picture_url: 'https://drive.google.com/uc?id=1zcO9ERuqsUVGgXBa0TCNdVgLvVHRvuzf'
      )
      parking.save
      subject.parking = parking
      subject.save

      expect(subject.parking).to eq(parking)
    end
  end
end
```  
Run the tests with the command  
`rails spec`  

You can find all the needed files in this repo.  

## Next steps
Make the tests pass, draw the routes, add controller actions with needed specs and add views.  
You can use Bootstrap for styling, but feel free to create your own css classes!  
Should you need any information or answers to your questions, write me [a mail](mailto:you.anthony@yahoo.com).  
Once you're done, share me your public repo.  

### Good luck!