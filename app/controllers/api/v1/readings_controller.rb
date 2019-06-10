class Api::V1::ReadingsController < ApplicationController

  def create
    ReadingJob.perform_later(@thermostat, build_params)
    render json: { message: "Saving is reading for number: #{sequence_number}" }, status: 200
  end

  def show
    render json: { data: Reading.search(@thermostat, reading_params[:id]) }, status: 200
  end


  private

    def reading_params
      params.permit(:temperature, :humidity, :battery_charge, :id)
    end

    def build_params
      reading_params.merge({ number: sequence_number })
    end

    def sequence_number
      @thermostat.get_next_sequence_number
    end

end