class ReadingJob < ApplicationJob

  queue_as :default

  def perform(thermostat, params)
    reading = thermostat.readings.new(params)

    reading.save ? { message: "Reading saved!" , status: 201 } : { errors:  reading.errors.messages, status: 400 }

  end

end
