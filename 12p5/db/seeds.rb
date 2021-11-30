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
