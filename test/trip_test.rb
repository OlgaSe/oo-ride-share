require_relative 'test_helper'

describe "Trip class" do
  describe "initialize" do
    before do
      start_time = Time.now - 60 * 60 # 60 minutes
      end_time = start_time + 25 * 60 # 25 minutes
      @trip_data = {
        id: 8,
        passenger: RideShare::Passenger.new(
          id: 1,
          name: "Ada",
          phone_number: "412-432-7640"
        ),
        start_time: start_time,
        end_time: end_time,
        cost: 23.45,
        rating: 3,
        driver: RideShare::Driver.new(
            id: 2,
            name: "Test",
            vin: "12345678901234567",
            status: :AVAILABLE
        )
      }
      @trip = RideShare::Trip.new(@trip_data)
    end

    it "is an instance of Trip" do
      expect(@trip).must_be_kind_of RideShare::Trip
    end

    it "stores an instance of passenger" do
      expect(@trip.passenger).must_be_kind_of RideShare::Passenger
    end

    it "stores an instance of driver" do
      skip # Unskip after wave 2
      expect(@trip.driver).must_be_kind_of RideShare::Driver
    end

    #####################
    it "raises argument error for start time after end time" do
      start_time = Time.parse('2015-05-20T12:14:00+00:00')
      end_time = start_time - 25 * 60 # 25 minutes
      @trip_data = {
          id: 8,
          passenger: RideShare::Passenger.new(id: 1,
                                              name: "Ada",
                                              phone_number: "412-432-7640"),
          start_time: start_time,
          end_time: end_time,
          cost: 23.45,
          rating: 3,
          driver: RideShare::Driver.new(
              id: 2,
              name: "Test",
              vin: "12345678901234567",
              status: :AVAILABLE
          )
      }
      #@trip2 = RideShare::Trip.new(@trip_data)

      expect{RideShare::Trip.new(@trip_data)}.must_raise ArgumentError
    end

    it "trip_duration is equal to the difference between start_time and end_time" do
      expect(@trip.trip_duration).must_equal 25*60
    end
    ############################

    it "raises an error for an invalid rating" do
      [-3, 0, 6].each do |rating|
        @trip_data[:rating] = rating
        expect do
          RideShare::Trip.new(@trip_data)
        end.must_raise ArgumentError
      end
    end
  end
end
