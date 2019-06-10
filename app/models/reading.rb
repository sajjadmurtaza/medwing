class Reading < ApplicationRecord
  belongs_to :thermostat

  validates :temperature, :humidity, :battery_charge, :thermostat_id,  presence: true, numericality: true
  validates :number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, uniqueness: { scope: :thermostat_id }

  def as_json(options={})
    super(except: [:created_at, :updated_at])
  end

  def self.search(thermostat, id)
    {
        thermostat: thermostat,
        reading: thermostat.readings.find_by(id: id)
    }
  end

end
