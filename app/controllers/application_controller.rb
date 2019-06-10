class ApplicationController < ActionController::API
  before_action :authorize_token

  def authorize_token
    begin
      @thermostat = Thermostat.find_by(household_token: request.headers['HouseholdToken'])

      render json: { message:  'Oops, No Thermostat found! Please double check that you entered correct HouseholdToken'}, status: 404 if @thermostat.nil?
    rescue
      render json: { errors:  'Bad Request'}, status: 400
    end
  end

  def routing_error
     render json: {error: 'You specified wrong route or method!'}
  end

end
