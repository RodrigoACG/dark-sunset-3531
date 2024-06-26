require "rails_helper"

RSpec.describe Airline, type: :model do
  describe "relationships" do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end

  describe '#model methods' do
    it 'older passengers' do
      @ar1 = Airline.create!(name: "United")
      @ar2 = Airline.create!(name: "South")


      @f1 = @ar1.flights.create!(number: "1234", date:"01/02/03", departure_city: "Denver", arrival_city: "PVR")
      @f2 = @ar1.flights.create!(number: "4321", date:"01/22/33", departure_city: "Cali", arrival_city: "KC")
      @f3 = @ar2.flights.create!(number: "4321", date:"01/22/33", departure_city: "Kc", arrival_city: "OK")

      @p1 = Passenger.create!(name:"Martin", age: 21, flights_id: @f1.id)
      @p2 = Passenger.create!(name:"Rodrigo", age: 19, flights_id: @f2.id)
      @p3 = Passenger.create!(name:"Ezequiel", age: 28, flights_id: @f2.id)
      @p4 = Passenger.create!(name:"bob", age: 8, flights_id: @f1.id)
      @p5 = Passenger.create!(name:"bill", age: 3, flights_id: @f1.id)
      

      @f1.passengers << [@p1, @p2, @p4, @p3]
      @f2.passengers << [@p2, @p1, @p5]
      @f3.passengers << [@p1, @p2, @p4, @p5]

      expect(@ar1.older_passengers).to eq([@p1, @p2, @p3])
      expect(@ar2.older_passengers).to eq([@p1, @p2])

    end
  end
end
