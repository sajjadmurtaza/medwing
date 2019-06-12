require 'rails_helper'

RSpec.describe 'Api V1 Readings Controller', type: :request do

  describe 'GET show' do
    it 'return 404 with no  token' do
      get '/api/v1/readings/1'
      expect(response).to have_http_status(404)
    end

    it 'return 404 with invalid  token' do
      get '/api/v1/readings/1', headers: { 'HouseholdToken' => :invalid_token }
      expect(response).to have_http_status(404)
    end

  end

end
