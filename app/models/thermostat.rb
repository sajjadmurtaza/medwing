class Thermostat < ApplicationRecord
  has_many :readings, dependent: :destroy

  validates :household_token, presence: true, uniqueness: true
  validates :location, presence: true

  def get_next_sequence_number
    (readings.pluck(:number).max || 0) + 1
  end

  def as_json(options={})
    super(except: [:created_at, :updated_at])
  end

  def self.stats(thermostat)
    data = []

    %i(avg min max).each do |stat|
      result = {}

      result["temperature_#{stat}"], result["humidity_#{stat}"], result["battery_charge_#{stat}"] = thermostat.readings.pluck(Arel.sql("#{stat}(temperature), #{stat}(humidity), #{stat}(battery_charge)")).first
      data << result
    end
    data
  end

end
