FactoryBot.define do
  factory :reading do
    association :thermostat, factory: :thermostat

    number { 1 }
    temperature { Faker::Number.decimal(4.3) }
    humidity { Faker::Number.decimal(3.2) }
    battery_charge { Faker::Number.decimal(5.5) }
    token { Faker::Lorem.characters(12121212121) }
  end
end