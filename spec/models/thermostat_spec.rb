require 'rails_helper'

RSpec.describe Thermostat, type: :model do

  describe 'associations' do
    it { should have_many(:readings) }
  end

  describe 'validation' do
    it { should validate_presence_of(:household_token) }
    it { should validate_uniqueness_of(:household_token) }
    it { should validate_presence_of(:location) }

    it "invalid without a household_token" do
      expect(build(:thermostat, household_token:nil)).to_not be_valid
    end

    it "invalid without a location" do
      expect(build(:thermostat, location:nil)).to_not be_valid
    end

  end

  context 'run methods' do

    let!(:thermostat) { build(:thermostat) }

    it { expect(Thermostat.new).to respond_to(:get_next_sequence_number) }

    it 'returns all thermostat attributes except created_at and updated_at' do
      expect(thermostat.as_json).not_to include(:created_at, :updated_at)
    end

  end


end