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
      subject.place = Place.new(
        name: 'Sample name',
        status: 'available',
        parking: parking
      )
      subject.save

      expect(subject.parking).to eq(parking)
    end
  end
end
