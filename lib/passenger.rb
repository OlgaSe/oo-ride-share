require_relative 'csv_record'

module RideShare
  class Passenger < CsvRecord
    attr_reader :name, :phone_number, :trips

    def initialize(id:, name:, phone_number:, trips: [])
      super(id)

      @name = name
      @phone_number = phone_number
      @trips = trips
    end

    def add_trip(trip)
      @trips << trip
    end

    def net_expenditures
      total_cost = 0
      @trips.each do |trip|
        total_cost += trip.cost.to_f
      end

      # total_cost = @trips.map { |trip| trip.cost}.sum

      return total_cost
    end

    def total_time_spent
      sum = 0
      @trips.each do |trip|
        sum += trip.trip_duration
      end
      return sum
    end


    private

    def self.from_csv(record)
      return new(
        id: record[:id],
        name: record[:name],
        phone_number: record[:phone_num]
      )
    end
  end
end
