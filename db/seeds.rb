10.times do
  Thermostat.create(
      household_token: Faker::Lorem.characters(20),
      location:  Faker::Address.full_address
  )
end