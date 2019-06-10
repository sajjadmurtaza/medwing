FactoryBot.define do
  factory :thermostat do
    household_token { Faker::Lorem.characters(20) }
    location { Faker::Address.full_address }
  end
end