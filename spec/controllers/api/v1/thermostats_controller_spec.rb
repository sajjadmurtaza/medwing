require 'rails_helper'

RSpec.describe 'Get average stats', type: :request do
  describe 'GET show' do
    let!(:thermostat) { create(:thermostat) }

    it 'return  404 no  token' do
      get '/api/v1/thermostats/stats'
      expect(response).to have_http_status(404)
    end

    it 'return 404 with invalid  token' do
      get '/api/v1/thermostats/stats', headers: { 'HouseholdToken' => :invalid_token }

      expect(response).to have_http_status(404)
    end

    it 'return 200 with valid token' do

      get '/api/v1/thermostats/stats', headers: { 'HouseholdToken' => thermostat.household_token }
      expect(response).to have_http_status(200)
    end

    it 'return error invalid route' do
      get '/api/v1/thermostat/stats', headers: { 'HouseholdToken' => thermostat.household_token }

      hash_body = JSON.parse(response.body)
      expect(hash_body.keys).to match_array(%w[error])
    end

  end
end