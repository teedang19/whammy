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
        expect(sorter.instance_variable_get(:@data)).to eql([{last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}, {last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "blue", date_of_birth: "01/13/1990"}])
      end
    end

    describe "#sort!" do
      context "by gender" do
        it "sorts @data by gender, female first, last name ascending" do
          expect(sorter.sort!(:gender)).to eql([{last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "blue", date_of_birth: "01/13/1990"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}])
        end
      end

      context "by birthday" do
        it "sorts @data by birthday, oldest first" do
          expect(sorter.sort!(:birthday)).to eql([{last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"},{last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "blue", date_of_birth: "01/13/1990"}])
        end
      end

      context "by last_name desc" do
        it "sorts @data by last_name, desc" do
          expect(sorter.sort!(:last_name)).to eql([{last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}, {last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "blue", date_of_birth: "01/13/1990"}])
        end
      end

      context "without sorting" do
        it "returns @data" do
          expect(sorter.sort!).to eql(sorter.instance_variable_get(:@data))
        end
      end
    end

    describe "#last_name_ascending" do
      xit "calls #last_name_sort with correct parameters" do
        expect(sorter).to receive(:last_name_sort).with(:asc)
        sorter.last_name_ascending
      end

      xit "sorts @data by last_name, ascending" do
        expect(sorter.last_name_ascending).to eql([{last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "blue", date_of_birth: "01/13/1990"}, {last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}])
      end
    end

    describe "#last_name_descending" do
      xit "calls #last_name_sort with correct parameters" do
        expect(sorter).to receive(:last_name_sort).with(:desc)
        sorter.last_name_descending
      end

      xit "sorts @data by last_name, descending" do
        expect(sorter.last_name_descending).to eql([{last_name: "Schuldiner", first_name: "Chuck", gender: "male", favorite_color: "orange", date_of_birth: "05/13/1967"}, {last_name: "Schemel", first_name: "Patty", gender: "female", favorite_color: "orange", date_of_birth: "04/24/1967"}, {last_name: "Reinhardt", first_name: "Django", gender: "male", favorite_color: "green", date_of_birth: "01/23/1910"}, {last_name: "Govan", first_name: "Guthrie", gender: "male", favorite_color: "blue", date_of_birth: "12/27/1971"}, {last_name: "Dang", first_name: "Tam", gender: "female", favorite_color: "blue", date_of_birth: "01/13/1990"}])
      end
    end
  end
end