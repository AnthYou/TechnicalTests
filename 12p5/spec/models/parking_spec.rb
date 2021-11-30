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
