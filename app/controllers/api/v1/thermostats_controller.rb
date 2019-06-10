class Api::V1::ThermostatsController < ApplicationController

  def stats
    render json: { data: Thermostat.stats(@thermostat) }, status: 200
  end

end