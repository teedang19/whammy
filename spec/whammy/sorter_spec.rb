require_relative "../spec_helper"

module Whammy
  describe Sorter do
    let(:sorter) { Sorter.new }

    before(:each) do
      allow_any_instance_of(Database).to receive(:data_file).and_return("data/example_db.txt")
    end

    describe "#initialize" do
      it "defines @data" do
        expect(sorter.instance_variable_get(:@data)).to_not be_nil
      end

      it "sets @data to the data read from the database" do
        expect(sorter.instance_variable_get(:@data)).to eql([{last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"},{last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"},{last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}])
      end
    end

    describe "#ladies_first" do
      it "sorts @data by gender, female first" do
        expect(sorter.ladies_first).to eql([{last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "blue", date_of_birth: "01/13/1990"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"},{last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"},{last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}])
      end
    end
  end
end